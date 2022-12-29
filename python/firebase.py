import pandas as pd
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import storage

# Firebase service account credentials
cred = credentials.Certificate(".service-account-file.json")
# Initializing app with credentials and storage bucket link
app = firebase_admin.initialize_app(cred, {
    'storageBucket': 'zentro-f581f.appspot.com'
})
# Firebase Firestore Database
firestore_client = firestore.client()
# Firebase Storage
bucket = storage.bucket()

# All Restaurant data CSV File as DataFrame
restaurants_data = pd.read_csv("restaurants.csv")

for idx in restaurants_data.index:
    # Converting each row to a dictionary data type
    restaurant_info = restaurants_data.loc[idx].to_dict()
    # Removing the collection name from dictionary and storing for later uses
    collection = restaurant_info.pop('collection')

    # New Collection and document based on the collection name received above
    rest_doc = firestore_client.collection("restaurants").document(collection)
    # Inserting basic data
    rest_doc.set({
        "name": restaurant_info['name'],
        "description":  restaurant_info['description'],
        "location":  restaurant_info['location'],
        "geo_location":  firestore.GeoPoint(
            float(restaurant_info['geo-location'].split(',')[0]),
            float(restaurant_info['geo-location'].split(',')[1])
        ),
        "image":  restaurant_info['image'],
        "menu": [],
    })

    # Uploading cover images to Storage
    image_path = f"{collection}/{restaurant_info['image']}"
    input_path = f"images/{image_path}"
    output_path = f"restaurants/{image_path}"
    blob = bucket.blob(output_path)
    blob.upload_from_filename(input_path)

    # Getting restaurants menu data CSV as DataFrame and removing NaN with empty string
    restaurant_csv = pd.read_csv(f"data/{collection}.csv").fillna('')
    menu = []
    for i in restaurant_csv.index:
        menu_item = restaurant_csv.loc[i].to_dict()
        item = {
            "name": menu_item['name'],
            "category": menu_item['category'],
            "price": float(menu_item['price']),
            "description": menu_item['description'],
            "image": menu_item['image'],
            "ingredients": menu_item['ingredients'].split(','),
            "veg": menu_item['veg'],
        }
        menu.append(item)

        # Uploading menu item images to Storage
        image_path = f"{collection}/{menu_item['image']}"
        input_path = f"images/{image_path}"
        output_path = f"restaurants/{image_path}"
        blob = bucket.blob(output_path)
        blob.upload_from_filename(input_path)

    # Updating the menu list with fetched data
    rest_doc.update({u'menu': menu})
    menu = []
