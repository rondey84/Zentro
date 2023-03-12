import pandas as pd
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import storage
from tqdm import tqdm

# Firebase service account credentials
cred = credentials.Certificate(".service-account-file.json")
# Initializing app with credentials and storage bucket link
app = firebase_admin.initialize_app(cred, {
    "storageBucket": 'zentro-f581f.appspot.com'
})
# Firebase Firestore Database
firestore_client = firestore.client()
# Firebase Storage
bucket = storage.bucket()

# All Restaurant data CSV File as DataFrame
restaurants_df = pd.read_csv("restaurants.csv").fillna('')

for idx in tqdm(restaurants_df.index, desc="Uploading Restaurant Data"):
    # Converting each row to a dictionary data type
    restaurant_info = restaurants_df.loc[idx].to_dict()
    # Removing the collection name from dictionary and storing for later uses
    res_id = restaurant_info.pop("collection")

    # New Collections and document based on the collection name received above
    rest_doc = firestore_client.collection("restaurants").document(res_id)
    menu_item_doc = firestore_client.collection("menus").document(res_id)

    # Inserting basic data
    rest_doc.set({
        "id": res_id,
        "name": restaurant_info['name'],
        "short_description":  restaurant_info['short_description'],
        "long_description":  restaurant_info['long_description'],
        "location":  restaurant_info['location'],
        "geo_location":  firestore.GeoPoint(
            float(restaurant_info['geo_location'].split(',')[0]),
            float(restaurant_info['geo_location'].split(',')[1])
        ),
        "image":  restaurant_info['image'],
        # "menu_image": restaurant_info['menu_image'].split(','),
    })

    # Uploading cover images to Storage
    image_path = f"{res_id}/{restaurant_info['image']}"
    input_path = f"images/{image_path}"
    output_path = f"restaurants/{image_path}"
    blob = bucket.blob(output_path)
    blob.upload_from_filename(input_path)

    # Getting restaurants menu data CSV as DataFrame and removing NaN with empty string
    menu_data_df = pd.read_csv(f"menu_data/{res_id}.csv").fillna('')
    categories = []
    for i in menu_data_df.index:
        menu_item = menu_data_df.loc[i].to_dict()

        if menu_item['category'] not in categories:
            categories.append(menu_item['category'])

        category_collection = menu_item_doc.collection(menu_item['category'])
        item_doc = category_collection.document(menu_item['id'])

        item = {
            "id": menu_item['id'],
            "name": menu_item['name'],
            "category": menu_item['category'],
            "price": float(menu_item['price']),
            "tax": float(menu_item['tax']),
            "description": menu_item['description'],
            "image": menu_item['image'],
            "ingredients": [item.strip() for item in menu_item['ingredients'].split(',') if item.strip()],
            "veg": menu_item['veg'],
        }

        if item_doc.get().exists:
            item_doc.update(item)
        else:
            item_doc.set(item)

        # Uploading menu item images to Storage
        image_path = f"{res_id}/{menu_item['image']}"
        input_path = f"images/{image_path}"
        output_path = f"restaurants/{image_path}"
        blob = bucket.blob(output_path)
        blob.upload_from_filename(input_path)

    # Setting the menu data with fetched data
    menu_item_doc.set({
        "restaurantId": res_id,
        "categories": categories,
        "recommended": [item.strip() for item in restaurant_info['recommended'].split(',') if item.strip()],
    })
