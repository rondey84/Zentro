part of '../svg_helper.dart';

abstract class Agree {
  static String getCode({
    required String primaryColor,
    String? secondaryColor,
    String? detailsColor,
  }) {
    return '''
      <svg width="718" height="431" viewBox="0 0 718 431" fill="none" xmlns="http://www.w3.org/2000/svg">
        <defs>
          <clipPath id="clip0_528_29">
            <rect width="717.67" height="430.743" fill="white"/>
          </clipPath>
        </defs>

        <g clip-path="url(#clip0_528_29)">
          <path d="M120.43 410.02C119.855 410.046 119.285 409.895 118.799 409.587C118.313 409.279 117.933 408.829 117.711 408.298C117.489 407.767 117.435 407.181 117.558 406.618C117.68 406.056 117.972 405.544 118.395 405.154L118.587 404.389C118.562 404.328 118.537 404.267 118.511 404.205C117.932 402.837 116.961 401.671 115.721 400.852C114.481 400.034 113.026 399.6 111.54 399.606C110.055 399.611 108.604 400.056 107.369 400.883C106.135 401.711 105.173 402.885 104.604 404.257C102.33 409.735 99.4339 415.223 98.7209 421.015C98.4069 423.575 98.5393 426.17 99.1124 428.685C93.7702 417.032 90.9961 404.366 90.9783 391.547C90.9772 388.33 91.1559 385.115 91.5137 381.918C91.8093 379.298 92.2195 376.695 92.7442 374.112C95.6075 360.094 101.755 346.955 110.682 335.775C115.003 333.417 118.497 329.792 120.694 325.387C121.49 323.804 122.052 322.114 122.364 320.369C121.877 320.433 120.526 313.01 120.894 312.555C120.215 311.524 118.999 311.012 118.257 310.006C114.568 305.004 109.485 305.877 106.831 312.675C101.162 315.536 101.107 320.28 104.586 324.844C106.799 327.747 107.103 331.676 109.044 334.784C108.845 335.039 108.637 335.287 108.437 335.543C104.785 340.238 101.603 345.28 98.9348 350.597C99.5837 344.641 98.8093 338.616 96.6754 333.018C94.5127 327.801 90.459 323.407 86.8894 318.896C82.6016 313.479 73.8091 315.843 73.0536 322.711C73.0463 322.777 73.0392 322.844 73.0322 322.91C73.5624 323.209 74.0815 323.527 74.5893 323.863C75.2273 324.289 75.7216 324.898 76.0075 325.61C76.2935 326.322 76.3577 327.104 76.1917 327.853C76.0257 328.602 75.6374 329.283 75.0775 329.808C74.5176 330.332 73.8123 330.676 73.0539 330.793L72.9763 330.805C73.1652 332.716 73.4991 334.609 73.9751 336.47C69.3956 354.18 79.2824 360.63 93.3994 360.92C93.711 361.08 94.0147 361.24 94.3264 361.391C91.6458 368.988 89.9644 376.901 89.3245 384.931C88.9621 389.668 88.9835 394.427 89.3884 399.161L89.3644 398.994C88.3415 393.729 85.5334 388.979 81.414 385.546C75.2958 380.52 66.6519 378.669 60.0514 374.629C59.3499 374.179 58.5343 373.939 57.7007 373.937C56.8671 373.935 56.0503 374.171 55.3466 374.618C54.643 375.065 54.0818 375.704 53.7293 376.459C53.3768 377.215 53.2477 378.055 53.3572 378.881C53.3661 378.94 53.3751 378.999 53.3842 379.058C54.3681 379.459 55.3262 379.92 56.2527 380.44C56.7829 380.739 57.3019 381.057 57.8097 381.393C58.4477 381.819 58.942 382.428 59.228 383.14C59.5139 383.852 59.5781 384.634 59.4121 385.383C59.2461 386.132 58.8578 386.813 58.2979 387.338C57.738 387.862 57.0327 388.206 56.2744 388.323L56.1967 388.335C56.1408 388.343 56.0928 388.351 56.037 388.359C57.7182 392.373 60.0777 396.068 63.0124 399.281C65.8759 414.741 78.1744 416.208 91.3299 411.706H91.3379C92.7814 417.978 94.8728 424.084 97.5784 429.924H119.871C119.951 429.676 120.023 429.42 120.095 429.173C118.031 429.302 115.96 429.179 113.926 428.805C115.58 426.776 117.234 424.73 118.888 422.701C118.925 422.663 118.96 422.623 118.992 422.581C119.831 421.542 120.678 420.511 121.517 419.473L121.518 419.471C121.562 416.287 121.196 413.11 120.43 410.02Z" fill="#F2F2F2"/>
          <path d="M586.052 410.02C586.627 410.046 587.196 409.895 587.682 409.587C588.169 409.279 588.549 408.829 588.771 408.298C588.993 407.767 589.046 407.181 588.924 406.618C588.801 406.056 588.509 405.544 588.086 405.154L587.894 404.389C587.919 404.328 587.945 404.267 587.97 404.205C588.55 402.837 589.52 401.671 590.76 400.852C592.001 400.034 593.455 399.6 594.941 399.606C596.427 399.611 597.878 400.056 599.112 400.883C600.346 401.711 601.308 402.885 601.877 404.257C604.152 409.735 607.047 415.223 607.76 421.015C608.074 423.575 607.942 426.17 607.369 428.685C612.711 417.032 615.485 404.366 615.503 391.547C615.504 388.33 615.325 385.115 614.968 381.918C614.672 379.298 614.262 376.695 613.737 374.112C610.874 360.094 604.726 346.955 595.799 335.775C591.478 333.417 587.984 329.792 585.787 325.387C584.991 323.804 584.429 322.114 584.117 320.369C584.605 320.433 585.955 313.01 585.587 312.555C586.267 311.524 587.482 311.012 588.224 310.006C591.914 305.004 596.997 305.877 599.65 312.675C605.319 315.536 605.374 320.28 601.896 324.844C599.683 327.747 599.379 331.676 597.437 334.784C597.637 335.039 597.845 335.287 598.044 335.543C601.696 340.238 604.878 345.28 607.546 350.597C606.898 344.641 607.672 338.616 609.806 333.018C611.969 327.801 616.022 323.407 619.592 318.896C623.88 313.479 632.672 315.843 633.428 322.711C633.435 322.777 633.442 322.844 633.449 322.91C632.919 323.209 632.4 323.527 631.892 323.863C631.254 324.289 630.76 324.898 630.474 325.61C630.188 326.322 630.124 327.104 630.29 327.853C630.456 328.602 630.844 329.283 631.404 329.808C631.964 330.332 632.669 330.676 633.427 330.793L633.505 330.805C633.316 332.716 632.982 334.609 632.506 336.47C637.086 354.18 627.199 360.63 613.082 360.92C612.77 361.08 612.467 361.24 612.155 361.391C614.836 368.988 616.517 376.901 617.157 384.931C617.519 389.668 617.498 394.427 617.093 399.161L617.117 398.994C618.14 393.729 620.948 388.979 625.067 385.546C631.186 380.52 639.829 378.669 646.43 374.629C647.131 374.179 647.947 373.939 648.781 373.937C649.614 373.935 650.431 374.171 651.135 374.618C651.838 375.065 652.4 375.704 652.752 376.459C653.105 377.215 653.234 378.055 653.124 378.881C653.115 378.94 653.106 378.999 653.097 379.058C652.113 379.459 651.155 379.92 650.229 380.44C649.698 380.739 649.179 381.057 648.672 381.393C648.034 381.819 647.539 382.428 647.253 383.14C646.967 383.852 646.903 384.634 647.069 385.383C647.235 386.132 647.624 386.813 648.183 387.338C648.743 387.862 649.449 388.206 650.207 388.323L650.285 388.335C650.341 388.343 650.388 388.351 650.444 388.359C648.763 392.373 646.404 396.068 643.469 399.281C640.605 414.741 628.307 416.208 615.151 411.706H615.143C613.7 417.978 611.609 424.084 608.903 429.924H586.61C586.53 429.676 586.458 429.42 586.386 429.173C588.45 429.302 590.521 429.179 592.555 428.805C590.901 426.776 589.247 424.73 587.593 422.701C587.556 422.663 587.521 422.623 587.489 422.581C586.65 421.542 585.803 420.511 584.964 419.473L584.964 419.471C584.919 416.287 585.285 413.11 586.052 410.02Z" fill="#F2F2F2"/>
          <path d="M146.07 429.424H182.044C188.196 408.708 182.077 359.749 190.186 339.738C205.745 301.369 225.622 260.885 262.721 242.151C278.561 234.151 295.832 231.027 313.47 231.197C337.836 231.428 362.886 237.969 385.821 246.637C395.203 250.175 404.499 254.065 413.758 258.04C448.643 273.03 483.149 289.358 520.664 293.771C568.135 299.351 623.949 278.112 636.914 232.364C646.81 197.339 628.988 160.976 610.298 129.695C591.608 98.4138 570.716 64.9445 574.129 28.7277C574.141 28.6061 574.153 28.4723 574.178 28.3508C575.462 15.3424 583.229 5.99358 594.079 0H546.84C546.216 33.7854 565.762 63.6072 583.351 93.0524C602.041 124.321 619.863 160.696 609.968 195.722C597.002 241.458 489.64 187.845 442.169 182.253C428.763 180.685 450.058 186.265 437.276 182.253C417.228 175.968 415.006 233.616 395.496 225.155C383.35 219.878 371.192 214.638 358.874 209.982C353.774 208.049 348.563 206.238 343.291 204.56C343.279 204.56 343.279 204.56 343.267 204.548C307.868 193.339 269.155 188.974 236.447 205.18C236.227 205.289 235.994 205.399 235.774 205.508C198.675 224.231 178.799 264.715 163.24 303.083C150.384 334.802 152.406 395.967 146.07 429.424Z" fill="#F2F2F2"/>
          <path d="M346.213 428.364C437.463 428.364 511.436 354.391 511.436 263.14C511.436 171.89 437.463 97.9172 346.213 97.9172C254.962 97.9172 180.989 171.89 180.989 263.14C180.989 354.391 254.962 428.364 346.213 428.364Z" fill="white"/>
          <path d="M345.741 429.425C182.269 433.18 178.685 355.516 178.685 263.14C178.685 170.766 253.838 95.6127 346.213 95.6127C438.588 95.6127 513.741 170.766 513.741 263.14C513.741 355.516 438.116 429.425 345.741 429.425ZM346.213 100.222C256.379 100.222 184.807 173.32 183.294 263.14C181.887 346.684 270.639 450.935 346.213 426.059C386.741 381.425 501.325 333.35 509.131 263.14C519.058 173.857 436.047 100.222 346.213 100.222Z" fill="#3F3D56"/>
          <path d="M323.672 349.131C320.819 349.131 318.005 348.467 315.453 347.191C312.902 345.914 310.682 344.061 308.971 341.778L263.895 281.677C262.446 279.746 261.391 277.549 260.791 275.21C260.191 272.872 260.058 270.438 260.399 268.048C260.74 265.658 261.548 263.359 262.778 261.281C264.008 259.204 265.635 257.389 267.567 255.94C269.498 254.492 271.696 253.438 274.035 252.839C276.373 252.241 278.807 252.108 281.197 252.451C283.587 252.793 285.886 253.602 287.963 254.833C290.04 256.064 291.854 257.692 293.301 259.624L322.791 298.941L398.532 185.331C401.237 181.278 405.441 178.465 410.22 177.51C414.998 176.556 419.96 177.538 424.014 180.241C428.069 182.944 430.884 187.146 431.841 191.924C432.798 196.702 431.818 201.665 429.117 205.721L338.966 340.947C337.335 343.392 335.142 345.411 332.57 346.834C329.998 348.257 327.122 349.043 324.184 349.125C324.013 349.128 323.843 349.131 323.672 349.131Z" fill="#F2F2F2"/>
          <path d="M5.26726e-06 429.553C-0.000460809 429.709 0.0300083 429.864 0.0896507 430.009C0.149293 430.153 0.236937 430.285 0.347539 430.395C0.458142 430.506 0.58951 430.593 0.734106 430.653C0.878702 430.713 1.03367 430.743 1.19008 430.743H716.48C716.796 430.743 717.098 430.617 717.322 430.394C717.545 430.171 717.67 429.868 717.67 429.553C717.67 429.237 717.545 428.934 717.322 428.711C717.098 428.488 716.796 428.363 716.48 428.363H1.19008C1.03368 428.362 0.878714 428.393 0.734121 428.452C0.589527 428.512 0.458156 428.6 0.347555 428.71C0.236954 428.821 0.14931 428.952 0.0896659 429.097C0.0300216 429.241 -0.0004555 429.396 5.26726e-06 429.553Z" fill="#CCCCCC"/>
          <path d="M451.72 417.887H442.046L437.444 380.57L451.723 380.571L451.72 417.887Z" fill="#FFB6B6"/>
          <path d="M452.061 427.98L422.311 427.979V427.602C422.311 424.531 423.531 421.586 425.702 419.415C427.874 417.243 430.819 416.023 433.89 416.023L439.325 411.9L449.464 416.023L452.062 416.024L452.061 427.98Z" fill="#2F2E41"/>
          <path d="M409.66 371.639L400.724 375.345L382.177 342.638L395.367 337.169L409.66 371.639Z" fill="#FFB6B6"/>
          <path d="M413.842 380.831L386.36 392.227L386.216 391.879C385.04 389.042 385.039 385.855 386.213 383.017C387.387 380.179 389.64 377.924 392.477 376.747L395.918 370.857L406.863 370.782L409.262 369.787L413.842 380.831Z" fill="#2F2E41"/>
          <path d="M462.782 205.609L394.124 212.783L384.94 243.715L353.134 294.829C353.134 294.829 375.327 332.183 373.244 331.776C371.16 331.369 375.325 341.552 378.242 340.96C381.16 340.369 384.193 347.008 382.177 348.189C380.16 349.369 388.252 359.35 388.252 359.35L400.619 348.25C403.25 328.407 400.071 310.747 388.748 296.148L424.181 257.895L430.9 255.107L436.233 397.054L455.96 397.378C461.403 369.377 464.137 344.175 459.883 326.197C459.883 326.197 460.494 272.188 462.827 272.779C465.16 273.369 463.182 266.333 463.182 266.333C463.182 266.333 461.139 260.341 463.649 257.855C466.16 255.369 464.592 240.748 464.592 240.748C468.74 226.912 467.492 215.487 462.782 205.609Z" fill="#2F2E41"/>
          <path d="M409.992 91.4583L428.973 86.5398L437.833 74.3198L458.874 76.9065L463.353 93.5747L478.333 102.27C478.333 102.27 470.053 189.841 472.023 194.65C473.992 199.458 481.054 199.061 475.023 205.26C468.992 211.458 468.193 208.962 469.593 215.71C470.992 222.458 481.193 229.6 469.593 229.529C457.992 229.458 387.992 228.458 389.992 220.458C391.992 212.458 391.961 214.49 394.976 209.474C397.992 204.458 400.022 207.261 399.007 199.86C397.992 192.458 398.992 187.458 398.992 183.458C398.992 179.458 402.343 143.11 402.343 143.11L409.992 91.4583Z" fill="#E6E6E6"/>
          <path d="M448.301 72.0611C460.615 72.0611 470.598 62.0781 470.598 49.7635C470.598 37.4489 460.615 27.4659 448.301 27.4659C435.986 27.4659 426.003 37.4489 426.003 49.7635C426.003 62.0781 435.986 72.0611 448.301 72.0611Z" fill="#FFB6B6"/>
          <path d="M424.937 36.269C426.894 37.8512 426.446 45.5458 428.628 44.2916C430.809 43.0375 431.263 40.7915 433.775 40.768C435.823 40.8811 437.755 41.7553 439.192 43.2192C439.459 43.4608 439.714 43.7142 439.961 43.9646C440.187 43.8854 440.41 43.8136 440.645 43.7548C442.407 43.3246 444.266 43.5865 445.841 44.4864C444.387 44.5903 443.002 45.1485 441.883 46.0823C442.362 46.6197 442.849 47.1601 443.361 47.6595C447.631 51.8444 456.387 47.3878 462.275 46.3822C457.371 51.7362 458.338 54.725 459.557 61.8812L459.562 62.2722C459.813 60.6218 465.099 60.7041 464.227 62.8939C463.133 65.0572 461.764 67.07 460.154 68.8825C467.355 63.8933 473.169 57.0161 474.454 48.7087C474.718 46.962 475.233 45.1798 474.735 43.4768C474.524 42.6157 474.033 41.8489 473.34 41.2962C472.646 40.7435 471.789 40.436 470.903 40.4217C471.705 37.8734 471.802 35.1553 471.183 32.5564C470.564 29.9576 469.252 27.575 467.387 25.6621C465.522 23.7492 463.173 22.3774 460.591 21.6927C458.009 21.0079 455.289 21.0357 452.721 21.7731C450.379 22.6056 448.094 23.5917 445.882 24.7251C443.649 25.8629 441.121 26.291 438.638 25.952C437.091 25.6325 435.524 24.8315 434.008 25.285C432.251 25.8119 431.496 27.6675 430.792 29.4587C432.113 29.9415 433.261 30.8074 434.089 31.9458C432.722 31.4415 431.231 31.3809 429.828 31.7727C429.803 31.7773 429.777 31.7842 429.753 31.7933C428.162 34.6439 428.07 35.3429 424.937 36.269Z" fill="#2F2E41"/>
          <path d="M432.289 80.5669C420.868 79.6474 410.44 88.3817 405.685 98.8064C400.931 109.231 400.62 121.057 400.389 132.512L399.671 168.121C399.565 173.39 399.459 178.66 399.196 183.924C399.061 189.046 398.417 194.142 397.273 199.136C394.945 208.301 389.823 216.468 384.775 224.465C397.698 228.371 410.84 231.509 424.132 233.864C430.771 212.393 437.485 190.304 435.853 167.889C434.989 156.028 431.799 144.448 430.587 132.617C428.869 115.862 431.145 98.9833 433.417 82.2942" fill="#3F3D56"/>
          <path d="M460.011 82.5696C471.323 84.3886 479.379 95.3493 481.522 106.605C483.665 117.86 481.159 129.422 478.663 140.605C476.076 152.191 473.49 163.778 470.904 175.365C469.755 180.509 468.607 185.653 467.612 190.829C466.645 195.857 470.694 202.305 470.74 207.425C470.826 216.88 468.989 224.668 471.993 233.634C458.513 234.36 445.002 234.288 431.53 233.419C430.181 210.985 428.904 187.934 435.812 166.548C439.467 155.231 445.316 144.739 449.304 133.535C454.951 117.667 456.748 100.731 458.504 83.9794" fill="#3F3D56"/>
          <path d="M467.553 244.221C466.713 242.757 466.477 241.023 466.896 239.388C467.315 237.752 468.356 236.345 469.796 235.465C470.092 235.291 470.401 235.142 470.722 235.019L469.279 185.903L484.906 181.925L478.947 239.147C479.354 240.515 479.298 241.979 478.786 243.312C478.274 244.644 477.336 245.769 476.117 246.512C475.42 246.928 474.647 247.202 473.843 247.32C473.04 247.437 472.221 247.395 471.434 247.196C470.646 246.997 469.906 246.645 469.255 246.16C468.603 245.674 468.054 245.066 467.638 244.368C467.609 244.319 467.581 244.27 467.553 244.221Z" fill="#FFB6B6"/>
          <path d="M466.412 102.191C466.412 102.191 477.319 92.9673 486.497 111.411C495.676 129.854 490.547 171.988 489.255 174.237C487.962 176.486 487.174 173.353 487.882 179.347C488.457 184.222 485.036 183.613 486.263 184.653C489.499 187.396 480.436 187.708 485.091 190.126C489.746 192.543 468.913 192.995 468.913 192.995C468.913 192.995 466.393 191.196 468.143 184.41C469.126 180.598 471.587 179.204 468.962 177.44C466.337 175.676 471.673 170.224 471.677 169.027C471.681 167.831 463.356 141.664 463.356 141.664L466.412 102.191Z" fill="#3F3D56"/>
          <path d="M376.152 329.399C373.299 329.399 370.485 328.735 367.933 327.458C365.381 326.182 363.162 324.329 361.45 322.046L316.375 261.945C314.925 260.014 313.871 257.817 313.271 255.478C312.671 253.14 312.538 250.706 312.879 248.316C313.219 245.926 314.028 243.626 315.258 241.549C316.488 239.471 318.115 237.657 320.046 236.208C321.978 234.76 324.175 233.706 326.514 233.107C328.853 232.508 331.287 232.376 333.677 232.718C336.067 233.06 338.366 233.87 340.442 235.101C342.519 236.331 344.333 237.959 345.781 239.892L375.271 279.208L451.012 165.598C452.351 163.59 454.072 161.865 456.077 160.522C458.083 159.179 460.333 158.244 462.7 157.771C465.066 157.298 467.503 157.295 469.871 157.764C472.239 158.232 474.491 159.162 476.499 160.501C478.507 161.84 480.232 163.561 481.575 165.566C482.918 167.572 483.853 169.822 484.326 172.189C484.8 174.556 484.802 176.992 484.334 179.36C483.866 181.728 482.935 183.98 481.597 185.988L391.446 321.215C389.815 323.66 387.622 325.679 385.049 327.102C382.477 328.525 379.602 329.311 376.663 329.393C376.493 329.396 376.322 329.399 376.152 329.399Z" fill="$primaryColor"/>
          <path d="M410.512 235.689C411.432 234.274 411.763 232.556 411.435 230.9C411.107 229.244 410.146 227.781 408.756 226.823C408.471 226.633 408.17 226.467 407.857 226.326L412.011 177.365L396.629 172.53L399.416 229.994C398.933 231.337 398.909 232.802 399.346 234.161C399.784 235.519 400.659 236.695 401.834 237.503C402.508 237.957 403.264 238.274 404.06 238.436C404.856 238.597 405.676 238.601 406.473 238.445C407.27 238.29 408.029 237.98 408.706 237.531C409.383 237.083 409.965 236.505 410.419 235.832C410.451 235.785 410.482 235.737 410.512 235.689Z" fill="#FFB6B6"/>
          <path d="M419.515 94.0408C419.515 94.0408 409.134 84.228 398.95 102.136C388.766 120.044 391.559 162.397 392.725 164.714C393.891 167.031 394.851 163.946 393.813 169.892C392.969 174.728 396.419 174.308 395.136 175.279C391.753 177.839 400.785 178.652 396.004 180.808C391.223 182.964 411.999 184.568 411.999 184.568C411.999 184.568 414.614 182.91 413.242 176.038C412.471 172.178 410.091 170.65 412.809 169.034C415.527 167.418 410.501 161.679 410.563 160.484C410.626 159.289 420.383 133.622 420.383 133.622L419.515 94.0408Z" fill="#3F3D56"/>
        </g>
      </svg>
    ''';
  }
}