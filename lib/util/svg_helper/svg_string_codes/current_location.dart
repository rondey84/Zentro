part of '../svg_helper.dart';

abstract class CurrentLocation {
  static String getCode({
    required String primaryColor,
    String? shirtColor,
    String? characterColor,
    String? skinColor,
    String? dotColor,
    String? shadowColor,
  }) {
    final String shirt = shirtColor ?? const Color(0xFF2F2E41).toRGBACode();
    final String char = characterColor ?? const Color(0xFF3F3D56).toRGBACode();
    final String skin = skinColor ?? const Color(0xFFFFB6B6).toRGBACode();
    final String dot = dotColor ?? Colors.white.toRGBACode();
    final String shadow = shadowColor ?? const Color(0xFF231F20).toRGBACode();

    return '''
    <svg width="284" height="423" viewBox="0 0 284 423" fill="none" xmlns="http://www.w3.org/2000/svg">
    <defs>
      <clipPath id="clip0_158_135">
      <rect width="284" height="423" fill="white"/>
      </clipPath>
    </defs>
    <g clip-path="url(#clip0_158_135)">
      <path d="M158.92 200.947C157.828 201.105 156.715 201.021 155.659 200.702C154.602 200.383 153.629 199.836 152.807 199.1C151.985 198.364 151.334 197.457 150.9 196.443C150.466 195.428 150.26 194.331 150.296 193.228L125.26 183.605L136.596 175.495L158.632 185.876C160.481 186.06 162.199 186.915 163.459 188.281C164.719 189.646 165.435 191.427 165.47 193.284C165.506 195.142 164.858 196.949 163.651 198.361C162.443 199.773 160.76 200.694 158.919 200.947L158.92 200.947Z" fill="$skin"/>
      <path d="M144.614 194.044L148.523 180.253L148.331 180.122L111.715 155.245L80.0624 123.48L61.6245 130.848L62.8352 136.684L62.9143 136.756L104.998 174.456L105.036 174.475L144.614 194.044Z" fill="$char"/>
      <path d="M107.103 225.545L50.4355 217.6L55.4228 182.822H97.1421L107.103 225.545Z" fill="$skin"/>
      <path d="M10.8154 395.84L22.44 398.542L38.3912 354.983L21.2348 350.996L10.8154 395.84Z" fill="$skin"/>
      <path d="M0 414.558L8.33617 416.496L11.6531 408.97L13.6351 417.727L35.7447 422.866C36.8045 423.113 37.9153 423.014 38.9149 422.584C39.9146 422.154 40.7507 421.416 41.3012 420.478C41.8517 419.539 42.0878 418.449 41.975 417.366C41.8622 416.284 41.4065 415.266 40.6743 414.461L25.8519 398.162L27.7009 390.203L8.87215 386.996L0 414.558Z" fill="$shirt"/>
      <path d="M82.541 402.319H94.4754L100.154 356.28H82.541V402.319Z" fill="$skin"/>
      <path d="M76.2427 423H84.801L86.3286 414.918L90.2411 423H112.94C114.028 423 115.088 422.652 115.964 422.007C116.84 421.362 117.488 420.454 117.812 419.415C118.135 418.376 118.119 417.261 117.764 416.232C117.409 415.204 116.735 414.315 115.839 413.697L97.7127 401.176V393.006L78.6467 394.144L76.2427 423Z" fill="$shirt"/>
      <path d="M49.7188 211.699L105.137 207.29C121.491 245.497 111.092 306.491 98.5249 375.153L80.6999 377.458L79.3173 267.127L34.633 369.768L16.0552 368.818L49.7188 211.699Z" fill="$shirt"/>
      <path d="M81.9774 111.087V92.3353C81.9774 85.6711 79.3305 79.2798 74.619 74.5675C69.9075 69.8552 63.5173 67.2079 56.8543 67.2079C50.1912 67.2079 43.801 69.8552 39.0895 74.5675C34.378 79.2798 31.7311 85.6711 31.7311 92.3353C27.3032 101.564 30.0733 105.952 31.7311 111.087C31.7326 111.982 32.0885 112.839 32.7208 113.471C33.3531 114.104 34.2102 114.46 35.1044 114.461H78.6025C79.4969 114.46 80.3545 114.104 80.9871 113.472C81.6198 112.839 81.9759 111.982 81.9774 111.087Z" fill="$shirt"/>
      <path d="M63.0539 114.178C73.2267 114.178 81.4735 105.93 81.4735 95.7556C81.4735 85.5811 73.2267 77.3329 63.0539 77.3329C52.881 77.3329 44.6343 85.5811 44.6343 95.7556C44.6343 105.93 52.881 114.178 63.0539 114.178Z" fill="$skin"/>
      <path d="M87.9204 93.835C87.9145 88.5652 85.8188 83.5129 82.0931 79.7866C78.3674 76.0603 73.316 73.9643 68.0471 73.9583H64.2972C59.0283 73.9642 53.9769 76.0603 50.2512 79.7866C46.5255 83.5129 44.4298 88.5652 44.4238 93.835V94.2102C47.2323 96.1304 49.8984 96.4113 52.3486 94.2102L55.0512 86.6407L55.5917 94.2101H59.6878L61.0532 90.3913L61.3262 94.2102C66.8587 98.9226 77.3203 96.6644 87.9204 94.2102V93.835Z" fill="$shirt"/>
      <path d="M52.3132 192.987L99.2111 191.202L101.833 160.516C103.854 154.9 103.887 150.074 101.93 146.182C100.246 142.984 97.4178 140.539 94.0098 139.336L83.7479 126.94C82.4278 125.346 80.7703 124.066 78.8952 123.192C77.02 122.317 74.9741 121.871 72.9053 121.884L46.2405 122.066C45.598 121.68 41.6994 119.698 34.0108 123.03C25.6716 126.645 27.6081 139.203 27.6289 139.329L27.6482 139.448L27.7398 139.528L45.4751 154.469L52.3132 192.987Z" fill="$char"/>
      <path d="M266.03 139.035C235.768 173.145 144.715 179.652 85.4469 242.265C65.5768 181.743 93.7254 77.2706 121.778 37.4297C135.249 18.2974 155.768 5.30106 178.82 1.29979C201.872 -2.70148 225.569 2.62005 244.698 16.0937C284.532 44.1511 298.367 102.586 266.03 139.035Z" fill="$primaryColor"/>
      <path d="M192.704 106.311C208.593 106.311 221.474 93.4278 221.474 77.5357C221.474 61.6435 208.593 48.7604 192.704 48.7604C176.815 48.7604 163.934 61.6435 163.934 77.5357C163.934 93.4278 176.815 106.311 192.704 106.311Z" fill="$dot"/>
      <path d="M61.1257 273.603C71.533 273.603 79.9697 265.165 79.9697 254.756C79.9697 244.347 71.533 235.909 61.1257 235.909C50.7185 235.909 42.2817 244.347 42.2817 254.756C42.2817 265.165 50.7185 273.603 61.1257 273.603Z" fill="$primaryColor"/>
      <path d="M39.5681 253.393C38.7474 252.656 38.0983 251.747 37.6664 250.732C37.2346 249.717 37.0304 248.619 37.0683 247.517C37.1062 246.414 37.3852 245.333 37.8858 244.35C38.3864 243.366 39.0963 242.505 39.9656 241.826L31.3052 216.438L44.7982 219.943L50.9472 243.513C51.992 245.05 52.4366 246.917 52.1967 248.76C51.9568 250.603 51.0492 252.294 49.6458 253.512C48.2424 254.73 46.4409 255.391 44.5828 255.369C42.7247 255.348 40.9392 254.645 39.5649 253.394L39.5681 253.393Z" fill="$skin"/>
      <path d="M35.6994 237.986L48.7908 232.151L44.3927 187.863L48.4888 143.205L31.0097 133.77L27.3064 138.44V138.546L25.3442 195.018L25.3547 195.06L35.6994 237.986Z" fill="$char"/>
      <path opacity="0.2" d="M217.596 63.7592C221.045 69.6569 222.283 76.5898 221.089 83.3171C219.894 90.0443 216.345 96.1268 211.076 100.476C205.807 104.825 199.163 107.157 192.332 107.054C185.502 106.951 178.931 104.42 173.795 99.9138C175.898 103.515 178.758 106.616 182.177 109.003C185.596 111.389 189.493 113.003 193.598 113.734C197.703 114.465 201.918 114.295 205.95 113.235C209.983 112.176 213.737 110.252 216.953 107.598C220.169 104.943 222.769 101.622 224.574 97.8626C226.379 94.1035 227.346 89.997 227.407 85.8273C227.468 81.6576 226.623 77.5244 224.929 73.714C223.235 69.9035 220.733 66.5069 217.596 63.7592Z" fill="$shadow"/>
      <path opacity="0.2" d="M252.919 24.5076C276.537 55.0498 280.61 98.9444 254.441 128.442C225.201 161.399 139.217 168.592 79.979 225.514C80.9653 231.45 82.3891 237.306 84.239 243.032C143.507 180.418 234.56 173.912 264.823 139.801C294.456 106.4 285.31 54.5385 252.919 24.5076Z" fill="$shadow"/>
    </g>

    </svg>
    ''';
  }
}
