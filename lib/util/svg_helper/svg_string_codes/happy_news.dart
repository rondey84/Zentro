part of '../svg_helper.dart';

abstract class HappyNews {
  static String getCode({
    required String primaryColor,
    String? secondaryColor,
    String? skinColor,
    String? leafColor,
    String? details1Color,
    String? details2Color,
    String? details3Color,
    String? deviceFrameColor,
    String? deviceBodyColor,
  }) {
    final String secondary =
        secondaryColor ?? const Color(0xFF2F1F11).toRGBACode();
    final String skin = skinColor ?? const Color(0xFFFFB6B6).toRGBACode();
    final String leaf = leafColor ?? const Color(0xFFF2F2F2).toRGBACode();
    final String details1 =
        details1Color ?? const Color(0xFF3F3D56).toRGBACode();
    final String details2 =
        details2Color ?? const Color(0xFFE6E6E6).toRGBACode();
    final String details3 =
        details3Color ?? const Color(0xFFFF6584).toRGBACode();
    final String deviceFrame =
        deviceFrameColor ?? const Color(0xFFCCCCCC).toRGBACode();
    final String deviceBody =
        deviceBodyColor ?? const Color(0xFFFFFFFF).toRGBACode();

    return '''
      <svg width="115" height="131" viewBox="0 0 115 131" fill="none" xmlns="http://www.w3.org/2000/svg">
        <defs>
          <clipPath id="clip0_495_129">
            <rect width="115" height="131" fill="white"/>
          </clipPath>
        </defs>
        
        <g clip-path="url(#clip0_495_129)">
          <path d="M73.9341 96.9884C74.1922 97.1268 74.4864 97.1823 74.777 97.1472C75.0675 97.1122 75.3403 96.9883 75.5584 96.7925C75.7765 96.5966 75.9293 96.3382 75.9961 96.0523C76.063 95.7663 76.0407 95.4666 75.9322 95.1939C75.9612 95.0487 75.9821 94.9445 76.0112 94.7993C76.5695 94.2763 77.2708 93.9325 78.0251 93.812C78.7793 93.6916 79.5523 93.7999 80.2448 94.1232C80.9373 94.4466 81.5178 94.9701 81.9119 95.6267C82.3061 96.2833 82.4959 97.0432 82.457 97.8088C82.2803 102.126 82.4927 106.786 79.6336 110.266C92.6831 99.5632 98.6332 81.33 94.6481 64.9308C92.6926 62.1959 91.7804 58.5627 92.6573 55.2703C93.7578 56.3446 95.9029 56.056 95.5751 54.1963C95.3992 53.4614 95.2172 52.7286 95.0414 51.9937C102.558 49.0499 104.52 60.2671 95.6167 64.8341C96.3389 67.9519 96.7345 71.1369 96.7969 74.3373C97.802 71.4516 99.4752 68.8465 101.679 66.7365C103.813 64.8083 106.634 63.6744 109.259 62.3807C112.453 60.8023 115.998 63.9315 114.74 67.272C112.614 66.9989 111.109 69.5497 113.039 70.9204C109.65 76.6328 103.152 80.2636 96.5505 80.3212C95.8828 86.8393 93.8387 93.1397 90.5544 98.8025C94.7718 92.3657 102.934 94.2189 109.384 93.9447C109.812 93.8905 110.246 93.9625 110.634 94.152C111.022 94.3414 111.346 94.64 111.568 95.0114C111.79 95.3828 111.899 95.8109 111.882 96.2436C111.866 96.6762 111.724 97.0946 111.474 97.4478C110.626 97.3978 109.775 97.4325 108.933 97.5515C108.537 97.6104 108.169 97.7907 107.879 98.0678C107.589 98.3448 107.392 98.7051 107.314 99.0991C107.236 99.4931 107.282 99.9017 107.445 100.269C107.607 100.636 107.879 100.943 108.223 101.149C102.564 106.356 93.7968 107.475 86.9156 104.153C84.8811 106.725 82.5858 109.078 80.0667 111.174L69.8364 106.279C69.8539 106.147 69.8769 106.014 69.898 105.884C70.8166 106.397 71.7943 106.795 72.8092 107.069C71.7178 102.893 70.5017 100.447 73.9337 96.9884H73.9341Z" fill="$leaf"/>
          <path d="M55.8569 87.11C55.6699 87.3359 55.4182 87.4987 55.1359 87.5762C54.8537 87.6537 54.5545 87.6423 54.2789 87.5435C54.0033 87.4447 53.7647 87.2632 53.5953 87.0237C53.4259 86.7842 53.334 86.4982 53.3319 86.2045C53.2505 86.0811 53.192 85.9925 53.1105 85.8691C52.3968 85.596 51.6182 85.5431 50.8744 85.7171C50.1305 85.8911 49.4554 86.2841 48.9356 86.8457C48.4157 87.4073 48.0748 88.112 47.9566 88.8693C47.8383 89.6267 47.9481 90.4022 48.2718 91.0965C50.0581 95.0284 51.6123 99.4237 55.5684 101.565C39.4604 96.593 27.0977 81.9594 24.6255 65.2629C25.4087 61.9896 24.8881 58.2794 22.8386 55.5623C22.2232 56.9738 20.1281 57.5187 19.7328 55.6723C19.6195 54.925 19.5127 54.1775 19.3993 53.4303C11.3321 53.5496 13.7302 64.6811 23.6921 65.54C24.1949 68.7009 25.0255 71.8004 26.1704 74.788C24.1551 72.496 21.6264 70.7169 18.7924 69.5971C16.0917 68.6192 13.0526 68.6372 10.1355 68.4328C6.58434 68.1803 4.47742 72.4203 6.89746 75.0379C8.76394 73.9801 11.1159 75.7728 9.84412 77.7728C15.1293 81.7802 22.5116 82.6827 28.6474 80.2366C31.7153 86.0204 35.9762 91.0815 41.146 95.0825C34.8211 90.718 27.9588 95.5244 21.8821 97.7124C21.4654 97.8243 21.0901 98.0554 20.8021 98.3777C20.5141 98.7 20.3257 99.0994 20.26 99.5273C20.1943 99.9552 20.254 100.393 20.432 100.787C20.61 101.182 20.8984 101.516 21.2622 101.748C22.0293 101.381 22.8308 101.091 23.655 100.882C24.0438 100.787 24.4524 100.814 24.8249 100.961C25.1974 101.108 25.5155 101.367 25.7357 101.703C25.9558 102.038 26.0671 102.434 26.0545 102.835C26.0418 103.237 25.9057 103.624 25.6649 103.945C32.8617 106.625 41.4023 104.342 46.5266 98.6598C49.3774 100.272 52.3875 101.582 55.5082 102.569L63.1433 94.1629C63.0776 94.0476 63.0061 93.9326 62.9377 93.8203C62.2797 94.643 61.5239 95.3817 60.687 96.02C60.1284 91.7394 60.3355 89.0137 55.8572 87.1098L55.8569 87.11Z" fill="$leaf"/>
          <path d="M57.8219 51.5889C58.1131 51.5594 58.3882 51.4408 58.6099 51.2491C58.8316 51.0574 58.9893 50.8019 59.0615 50.5173C59.1338 50.2327 59.1171 49.9326 59.0138 49.6578C58.9104 49.383 58.7254 49.1468 58.4838 48.981C58.4273 48.8443 58.3868 48.7461 58.3303 48.6093C58.5032 47.8626 58.8944 47.1848 59.4536 46.6627C60.0128 46.1406 60.7147 45.798 61.4692 45.6789C62.2236 45.5597 62.9964 45.6694 63.6883 45.994C64.3803 46.3185 64.9599 46.843 65.3529 47.5004C67.6046 51.1836 70.3691 54.9323 69.9291 59.422C74.8166 43.2341 69.6276 24.7681 57.2098 13.3846C54.0673 12.2086 51.2918 9.70298 50.1909 6.47908C51.7012 6.75503 53.3216 5.31501 52.0165 3.95468C51.4622 3.44299 50.9041 2.93656 50.3499 2.42484C54.9541 -4.22507 62.8142 3.98861 57.9602 12.7623C60.2917 14.9463 62.3893 17.369 64.2189 19.9908C63.4502 17.0328 63.3922 13.9339 64.0497 10.9489C64.7498 8.15415 66.4621 5.63397 67.9224 3.09114C69.6971 -0.00652198 74.3779 0.607418 75.1896 4.08426C73.2729 5.04743 73.4409 8.00686 75.804 8.06503C76.164 14.7035 72.7868 21.3539 67.3383 25.0963C70.4048 30.8808 72.2077 37.2549 72.6269 43.7938C72.5524 36.0902 80.3572 33.0612 85.5594 29.224C85.8846 28.9395 86.2852 28.7562 86.7124 28.6964C87.1396 28.6366 87.575 28.7028 87.9653 28.8871C88.3556 29.0714 88.6841 29.3657 88.9106 29.7341C89.1371 30.1026 89.2519 30.5292 89.241 30.962C88.5088 31.3954 87.8214 31.9006 87.1887 32.4704C86.8928 32.7408 86.6874 33.0965 86.6008 33.4887C86.5141 33.8808 86.5504 34.2903 86.7048 34.661C86.8591 35.0316 87.1238 35.3452 87.4627 35.5589C87.8015 35.7726 88.198 35.8759 88.5976 35.8546C86.7926 43.343 80.1359 49.1786 72.5781 50.2715C72.318 53.5453 71.7197 56.7831 70.7927 59.9328L59.5811 61.5946C59.5225 61.4755 59.4674 61.3518 59.4128 61.2321C60.4602 61.1438 61.4929 60.927 62.4878 60.5867C59.2621 57.7309 56.8939 56.381 57.8216 51.5891L57.8219 51.5889Z" fill="$leaf"/>
          <path d="M69.0983 47.9807C63.9941 47.9807 61.2256 47.3547 60.2587 46.0183C59.4056 44.8392 59.9775 43.2835 60.6398 41.4822C61.1158 40.1874 61.6552 38.72 61.6552 37.2676C61.6552 30.2036 65.2238 26.6218 72.2617 26.6218C75.7634 26.6218 79.5232 28.4888 82.3193 31.6162C84.8611 34.4593 86.1274 37.862 85.7935 40.9517C85.5195 43.4857 84.3444 45.1521 82.0953 46.1963L81.9638 46.2573L81.9264 46.1168C81.7322 45.3895 81.4035 44.7054 80.9574 44.1C80.914 45.0503 80.6753 45.9813 80.2564 46.8345L80.2325 46.8831L80.1806 46.8981C77.635 47.6258 74.6139 47.823 72.2664 47.9133C71.1238 47.958 70.0678 47.9805 69.0983 47.9807Z" fill="$secondary"/>
          <path d="M70.4894 57.823C70.2937 57.2458 69.9638 56.7238 69.5269 56.3002C69.09 55.8766 68.5587 55.5638 67.9772 55.3875C67.3957 55.2113 66.7808 55.1768 66.1833 55.2869C65.5859 55.397 65.0232 55.6485 64.542 56.0205L47.7528 66.0955L42.4992 53.2292C42.943 52.5757 43.1692 51.7979 43.1454 51.0074C43.1216 50.2169 42.849 49.4543 42.3666 48.8289C41.8843 48.2035 41.217 47.7476 40.4605 47.5264C39.704 47.3052 38.8971 47.3301 38.1556 47.5976C37.4141 47.8652 36.7761 48.3615 36.333 49.0155C35.89 49.6695 35.6646 50.4475 35.6893 51.238C35.714 52.0285 35.9875 52.7908 36.4706 53.4156C36.9536 54.0405 37.6214 54.4957 38.3782 54.716C38.702 58.4262 40.5015 75.0095 46.7618 74.4067C52.0238 73.9 65.0916 65.1648 69.1505 62.1361C69.7998 61.652 70.2794 60.9736 70.52 60.1985C70.7606 59.4234 70.7499 58.5916 70.4894 57.823Z" fill="$skin"/>
          <path d="M83.1413 131H68.5287L66.0782 118.839L65.2834 131H51.7095C51.7147 121.45 52.2103 111.907 53.1944 102.408L53.3626 101.833L53.6284 100.913L53.7966 100.335L56.6055 90.6535L56.8274 89.885H73.7418C74.7151 90.8027 75.6129 91.7979 76.4263 92.8609C76.7018 93.2134 76.9895 93.5951 77.2846 94.0063C77.4894 94.2975 77.7015 94.6034 77.9136 94.924C79.7983 97.7402 81.2071 100.849 82.0831 104.126V104.128C82.2318 104.689 82.3635 105.262 82.4781 105.849V105.851C82.5805 106.373 82.6707 106.901 82.7414 107.442C82.7951 107.836 82.8414 108.235 82.8756 108.639C83.0788 110.876 83.0076 113.13 82.6634 115.349L83.1413 131Z" fill="$secondary"/>
          <path d="M5.66518 19.8039C6.61415 19.4352 7.17629 18.5991 6.92075 17.9365C6.6652 17.2739 5.68874 17.0356 4.73976 17.4044C3.79078 17.7731 3.22865 18.6091 3.48419 19.2717C3.73974 19.9343 4.7162 20.1726 5.66518 19.8039Z" fill="$details2"/>
          <path d="M17.6134 18.2655C18.5624 17.8968 19.1245 17.0607 18.869 16.3981C18.6134 15.7355 17.637 15.4972 16.688 15.866C15.739 16.2347 15.1769 17.0707 15.4324 17.7333C15.688 18.3959 16.6644 18.6342 17.6134 18.2655Z" fill="$details1"/>
          <path d="M4.62856 30.0357C5.57754 29.667 6.13968 28.8309 5.88413 28.1683C5.62859 27.5057 4.65212 27.2674 3.70314 27.6362C2.75417 28.0049 2.19202 28.8409 2.44757 29.5035C2.70312 30.1661 3.67958 30.4044 4.62856 30.0357Z" fill="$details3"/>
          <path d="M1.17237 34.549C1.60773 34.4455 1.84058 33.8525 1.69245 33.2243C1.54432 32.5962 1.0713 32.1708 0.635944 32.2742C0.200584 32.3776 -0.0322612 32.9707 0.115868 33.5989C0.263996 34.227 0.737007 34.6524 1.17237 34.549Z" fill="$details2"/>
          <path d="M1.10108 42.1901C1.53644 42.0867 1.76928 41.4936 1.62115 40.8655C1.47303 40.2373 1.00002 39.812 0.564655 39.9154C0.129295 40.0188 -0.10355 40.6119 0.0445785 41.24C0.192707 41.8682 0.665718 42.2936 1.10108 42.1901Z" fill="$details1"/>
          <path d="M11.5879 26.3635C12.0233 26.2601 12.2561 25.667 12.108 25.0389C11.9598 24.4107 11.4868 23.9854 11.0515 24.0888C10.6161 24.1922 10.3833 24.7853 10.5314 25.4134C10.6795 26.0416 11.1525 26.467 11.5879 26.3635Z" fill="$details2"/>
          <path d="M5.29493 24.8297C5.73029 24.7263 5.96313 24.1332 5.815 23.5051C5.66687 22.8769 5.19386 22.4515 4.7585 22.555C4.32314 22.6584 4.0903 23.2515 4.23843 23.8796C4.38655 24.5078 4.85957 24.9331 5.29493 24.8297Z" fill="$details3"/>
          <path d="M11.9648 17.7935C12.4002 17.69 12.6331 17.097 12.4849 16.4688C12.3368 15.8407 11.8638 15.4153 11.4284 15.5187C10.9931 15.6221 10.7602 16.2152 10.9083 16.8434C11.0565 17.4715 11.5295 17.8969 11.9648 17.7935Z" fill="$details1"/>
          <path d="M15.0671 70.6794C15.5259 70.1384 15.2697 69.1631 14.4949 68.5011C13.72 67.839 12.7198 67.7409 12.261 68.282C11.8021 68.8231 12.0583 69.7983 12.8332 70.4604C13.6081 71.1224 14.6083 71.2205 15.0671 70.6794Z" fill="$details2"/>
          <path d="M8.02999 60.866C8.48883 60.3249 8.23263 59.3496 7.45774 58.6876C6.68286 58.0256 5.68272 57.9275 5.22388 58.4685C4.76503 59.0096 5.02124 59.9849 5.79612 60.6469C6.57101 61.3089 7.57114 61.407 8.02999 60.866Z" fill="$details1"/>
          <path d="M24.5246 66.7222C24.9835 66.1812 24.7273 65.2059 23.9524 64.5438C23.1775 63.8818 22.1773 63.7837 21.7185 64.3248C21.2597 64.8658 21.5159 65.8411 22.2908 66.5032C23.0656 67.1652 24.0658 67.2633 24.5246 66.7222Z" fill="$details3"/>
          <path d="M29.223 66.8306C29.7028 66.4008 29.8502 65.7807 29.5523 65.4457C29.2544 65.1107 28.624 65.1876 28.1442 65.6174C27.6643 66.0472 27.5169 66.6673 27.8148 67.0023C28.1127 67.3373 28.7432 67.2604 29.223 66.8306Z" fill="$details2"/>
          <path d="M35.9515 63.255C36.4313 62.8252 36.5788 62.2052 36.2808 61.8702C35.9829 61.5351 35.3525 61.612 34.8727 62.0418C34.3929 62.4717 34.2454 63.0917 34.5433 63.4267C34.8412 63.7617 35.4717 63.6849 35.9515 63.255Z" fill="$details1"/>
          <path d="M17.0926 61.5349C17.5724 61.105 17.7199 60.485 17.422 60.15C17.124 59.815 16.4936 59.8919 16.0138 60.3217C15.534 60.7515 15.3865 61.3716 15.6844 61.7066C15.9823 62.0416 16.6128 61.9647 17.0926 61.5349Z" fill="$details2"/>
          <path d="M18.745 67.8195C19.2248 67.3897 19.3722 66.7697 19.0743 66.4347C18.7764 66.0997 18.1459 66.1765 17.6661 66.6064C17.1863 67.0362 17.0389 67.6562 17.3368 67.9912C17.6347 68.3263 18.2651 68.2494 18.745 67.8195Z" fill="$details3"/>
          <path d="M9.40462 65.2827C9.88442 64.8528 10.0319 64.2328 9.73396 63.8978C9.43605 63.5628 8.8056 63.6397 8.32579 64.0695C7.84599 64.4993 7.69853 65.1194 7.99644 65.4544C8.29436 65.7894 8.92482 65.7125 9.40462 65.2827Z" fill="$details1"/>
          <path d="M62.3419 7.73914C62.9771 7.42558 63.128 6.42839 62.6789 5.51186C62.2299 4.59533 61.3508 4.10653 60.7156 4.4201C60.0804 4.73366 59.9295 5.73085 60.3786 6.64738C60.8277 7.5639 61.7067 8.05271 62.3419 7.73914Z" fill="$details2"/>
          <path d="M64.9156 19.551C65.5508 19.2374 65.7018 18.2402 65.2527 17.3237C64.8036 16.4072 63.9246 15.9184 63.2893 16.2319C62.6541 16.5455 62.5032 17.5427 62.9523 18.4592C63.4014 19.3757 64.2804 19.8645 64.9156 19.551Z" fill="$details1"/>
          <path d="M52.0963 7.59955C52.7315 7.28598 52.8824 6.2888 52.4333 5.37227C51.9842 4.45574 51.1052 3.96694 50.47 4.2805C49.8348 4.59407 49.6839 5.59126 50.133 6.50779C50.582 7.42432 51.4611 7.91311 52.0963 7.59955Z" fill="$details3"/>
          <path d="M46.7114 3.85111C47.3218 3.64797 47.7025 3.13776 47.5617 2.71153C47.4209 2.2853 46.8119 2.10445 46.2015 2.30759C45.5911 2.51073 45.2103 3.02095 45.3511 3.44718C45.4919 3.87341 46.1009 4.05426 46.7114 3.85111Z" fill="$details2"/>
          <path d="M39.1215 4.44956C39.732 4.24642 40.1127 3.73621 39.9719 3.30998C39.8311 2.88375 39.2221 2.7029 38.6116 2.90604C38.0012 3.10919 37.6205 3.61939 37.7613 4.04562C37.9021 4.47186 38.5111 4.65271 39.1215 4.44956Z" fill="$details1"/>
          <path d="M55.7475 13.548C56.3579 13.3449 56.7387 12.8347 56.5979 12.4084C56.4571 11.9822 55.8481 11.8013 55.2376 12.0045C54.6272 12.2076 54.2465 12.7178 54.3873 13.1441C54.5281 13.5703 55.1371 13.7512 55.7475 13.548Z" fill="$details2"/>
          <path d="M56.7187 7.12168C57.3291 6.91853 57.7099 6.40833 57.5691 5.98209C57.4283 5.55586 56.8193 5.37501 56.2088 5.57816C55.5984 5.7813 55.2177 6.29151 55.3584 6.71774C55.4992 7.14398 56.1082 7.32482 56.7187 7.12168Z" fill="$details3"/>
          <path d="M64.2861 13.1742C64.8965 12.971 65.2772 12.4608 65.1365 12.0346C64.9957 11.6084 64.3867 11.4275 63.7762 11.6306C63.1658 11.8338 62.785 12.344 62.9258 12.7702C63.0666 13.1965 63.6756 13.3773 64.2861 13.1742Z" fill="$details1"/>
          <path d="M66.6295 49.9473L74.6797 49.5311L78.4188 55.4612C78.4188 55.4612 85.454 56.6418 84.9664 64.9627C84.4787 73.2836 76.4066 80.5852 76.4066 80.5852L76.7517 84.9183L76.1524 86.637L76.2292 87.6021L77.0468 88.6241L77.1309 89.6811L76.4066 91.3534L77.3916 92.9546L56.6824 90.9408L55.9251 88.1719L57.0298 86.685L56.4127 84.7456L57.3404 82.8803L57.8241 76.9551C57.8241 76.9551 52.532 68.975 58.6072 62.9645L61.0455 58.804L63.7737 55.4631L66.6295 49.9473Z" fill="$primaryColor"/>
          <path d="M70.6317 48.2728C75.3428 48.2728 79.1618 44.4396 79.1618 39.7111C79.1618 34.9825 75.3428 31.1493 70.6317 31.1493C65.9206 31.1493 62.1016 34.9825 62.1016 39.7111C62.1016 44.4396 65.9206 48.2728 70.6317 48.2728Z" fill="$skin"/>
          <path d="M69.4892 39.1921C68.7542 39.1921 68.0195 39.1713 67.2852 39.1297L67.154 39.1223L67.1713 38.9916C67.2795 38.1744 67.2186 37.3435 66.9925 36.551C66.6085 37.4534 66.0372 38.2633 65.3167 38.9266L65.2759 38.964L65.2212 38.958C63.227 38.7391 61.251 38.3774 59.3082 37.8756L59.2338 37.8565L59.2189 37.781C59.0738 37.0658 58.9987 36.3381 58.9946 35.6083C58.9946 33.3284 59.8181 31.4095 61.3136 30.205C62.9412 28.894 65.2745 28.4908 67.8858 29.0691H76.2357C77.1537 29.0701 78.0337 29.4366 78.6828 30.0881C79.3319 30.7396 79.6971 31.623 79.6981 32.5443V37.8516L79.607 37.8755C76.3044 38.7467 72.904 39.1892 69.4892 39.1921Z" fill="$secondary"/>
          <path d="M11.2845 29.6687C10.9107 29.8059 10.6064 30.0863 10.4384 30.4484C10.2703 30.8106 10.2523 31.2248 10.3881 31.6003L19.3959 56.4085C19.5326 56.7837 19.812 57.0891 20.1728 57.2578C20.5336 57.4265 20.9463 57.4446 21.3204 57.3083L56.2812 44.5198C56.655 44.3826 56.9593 44.1021 57.1273 43.74C57.2954 43.3779 57.3134 42.9636 57.1776 42.5881L48.1698 17.7799C48.0331 17.4047 47.7537 17.0993 47.3929 16.9306C47.0321 16.7619 46.6194 16.7438 46.2453 16.8802L11.2845 29.6687Z" fill="$deviceFrame"/>
          <path d="M43.2693 47.9117L21.8697 55.7395C21.467 55.8863 21.0229 55.8668 20.6345 55.6852C20.2462 55.5037 19.9455 55.1749 19.7984 54.7711L11.6284 32.2703C11.4822 31.8662 11.5016 31.4203 11.6825 31.0306C11.8634 30.6408 12.1909 30.339 12.5932 30.1913L45.5784 18.1255C45.9811 17.9787 46.4253 17.9982 46.8136 18.1798C47.2019 18.3613 47.5026 18.6901 47.6497 19.0939L51.5974 29.9661C52.8596 33.4545 52.6916 37.303 51.1303 40.6673C49.5691 44.0316 46.742 46.6369 43.2693 47.9117Z" fill="$deviceBody"/>
          <path d="M27.8714 31.6567L22.7861 33.5169C22.7224 33.5402 22.6546 33.5507 22.5868 33.5478C22.519 33.5448 22.4524 33.5285 22.3909 33.4997C22.3294 33.471 22.2741 33.4303 22.2282 33.3801C22.1823 33.3299 22.1468 33.2711 22.1235 33.2071C22.1003 33.1431 22.0898 33.0751 22.0928 33.0071C22.0957 32.939 22.112 32.8722 22.1406 32.8104C22.1693 32.7487 22.2098 32.6932 22.2598 32.6471C22.3098 32.6011 22.3684 32.5654 22.4322 32.542L27.5174 30.6819C27.6462 30.6348 27.7884 30.6409 27.9127 30.699C28.0369 30.7571 28.1331 30.8624 28.18 30.9917C28.227 31.1209 28.2208 31.2636 28.163 31.3883C28.1051 31.5131 28.0002 31.6096 27.8714 31.6567Z" fill="$primaryColor"/>
          <path d="M39.9947 29.4804L23.5099 35.5105C23.4461 35.5339 23.3783 35.5444 23.3104 35.5416C23.2426 35.5387 23.1759 35.5224 23.1143 35.4936C23.0527 35.4649 22.9974 35.4242 22.9515 35.374C22.9055 35.3238 22.8699 35.2649 22.8467 35.2009C22.8234 35.1368 22.813 35.0688 22.8159 35.0007C22.8189 34.9326 22.8352 34.8657 22.8639 34.8039C22.8926 34.7421 22.9332 34.6866 22.9833 34.6406C23.0334 34.5945 23.0921 34.5589 23.1559 34.5356L39.6407 28.5055C39.7045 28.4822 39.7722 28.4717 39.84 28.4747C39.9078 28.4776 39.9744 28.4939 40.0359 28.5227C40.0974 28.5515 40.1527 28.5921 40.1986 28.6423C40.2445 28.6925 40.2801 28.7513 40.3033 28.8153C40.3265 28.8793 40.337 28.9473 40.3341 29.0154C40.3311 29.0834 40.3149 29.1503 40.2862 29.212C40.2576 29.2738 40.217 29.3293 40.167 29.3753C40.117 29.4214 40.0584 29.4571 39.9947 29.4804Z" fill="$primaryColor"/>
          <path d="M40.8256 31.7687L24.3408 37.7988C24.2771 37.8221 24.2093 37.8326 24.1415 37.8297C24.0737 37.8267 24.0071 37.8104 23.9456 37.7817C23.8841 37.7529 23.8288 37.7122 23.7829 37.662C23.737 37.6118 23.7015 37.553 23.6782 37.489C23.655 37.425 23.6445 37.357 23.6475 37.289C23.6504 37.2209 23.6666 37.1541 23.6953 37.0923C23.724 37.0306 23.7645 36.9751 23.8145 36.929C23.8645 36.883 23.9231 36.8473 23.9869 36.824L40.4716 30.7939C40.6004 30.747 40.7424 30.7533 40.8666 30.8114C40.9907 30.8695 41.0867 30.9747 41.1336 31.1039C41.1806 31.2331 41.1745 31.3756 41.1167 31.5003C41.0589 31.625 40.9542 31.7215 40.8256 31.7687Z" fill="$primaryColor"/>
          <path d="M41.6563 34.0571L25.1715 40.0872C25.1077 40.1106 25.0399 40.1212 24.9721 40.1183C24.9042 40.1154 24.8376 40.0991 24.776 40.0704C24.7144 40.0416 24.659 40.001 24.6131 39.9507C24.5672 39.9005 24.5316 39.8417 24.5083 39.7776C24.485 39.7135 24.4746 39.6455 24.4775 39.5774C24.4805 39.5093 24.4968 39.4424 24.5255 39.3806C24.5542 39.3188 24.5948 39.2633 24.6449 39.2173C24.695 39.1713 24.7537 39.1356 24.8175 39.1123L41.3023 33.0823C41.3661 33.0589 41.4338 33.0484 41.5016 33.0514C41.5694 33.0543 41.636 33.0707 41.6975 33.0994C41.7591 33.1282 41.8143 33.1688 41.8602 33.219C41.9061 33.2693 41.9417 33.328 41.9649 33.3921C41.9882 33.4561 41.9986 33.524 41.9957 33.5921C41.9927 33.6602 41.9765 33.727 41.9478 33.7887C41.9192 33.8505 41.8787 33.906 41.8286 33.952C41.7786 33.9981 41.7201 34.0338 41.6563 34.0571Z" fill="$primaryColor"/>
          <path d="M42.4872 36.3454L26.0024 42.3755C25.8737 42.4226 25.7315 42.4164 25.6072 42.3583C25.483 42.3003 25.3868 42.195 25.3398 42.0657C25.2929 41.9364 25.299 41.7938 25.3569 41.669C25.4148 41.5443 25.5197 41.4478 25.6485 41.4007L42.1333 35.3706C42.197 35.3473 42.2648 35.3368 42.3326 35.3397C42.4004 35.3427 42.467 35.359 42.5285 35.3877C42.59 35.4165 42.6453 35.4572 42.6912 35.5074C42.7371 35.5576 42.7726 35.6164 42.7959 35.6804C42.8191 35.7444 42.8296 35.8124 42.8266 35.8804C42.8237 35.9485 42.8074 36.0153 42.7788 36.0771C42.7501 36.1388 42.7096 36.1943 42.6596 36.2404C42.6096 36.2864 42.551 36.3221 42.4872 36.3454Z" fill="$primaryColor"/>
          <path d="M94.7935 42.7008L85.768 64.3791C85.3829 65.2964 84.6539 66.025 83.7384 66.4076C82.8228 66.7902 81.7941 66.7961 80.8742 66.4241C80.3983 66.2317 79.9665 65.944 79.605 65.5786C79.2435 65.2132 78.9599 64.7777 78.7716 64.2987C78.5833 63.8197 78.4941 63.3072 78.5095 62.7925C78.525 62.2778 78.6447 61.7716 78.8613 61.3048L88.9245 39.0748L94.472 25.3083C93.9926 24.8284 93.672 24.212 93.5538 23.5429C93.4356 22.8738 93.5255 22.1844 93.8112 21.5684C94.097 20.9523 94.5647 20.4395 95.151 20.0996C95.7372 19.7596 96.4135 19.6091 97.088 19.6684C97.7624 19.7277 98.4023 19.9939 98.9208 20.431C99.4392 20.868 99.811 21.4546 99.9858 22.1111C100.16 22.7677 100.13 23.4623 99.8973 24.1006C99.665 24.7389 99.2426 25.2899 98.6874 25.6788L94.7935 42.7008Z" fill="$skin"/>
        </g>
      </svg>
    ''';
  }
}