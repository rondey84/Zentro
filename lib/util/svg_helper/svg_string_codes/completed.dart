part of '../svg_helper.dart';

abstract class Completed {
  static String getCode({
    String? primaryColor,
    String? secondaryColor,
  }) {
    // final String secondary =
    //     secondaryColor ?? const Color(0xFF2F1F11).toRGBACode();

    return '''
    <svg width="328" height="274" viewBox="0 0 328 274" fill="none" xmlns="http://www.w3.org/2000/svg">
      <defs>
        <clipPath id="clip0_509_219">
          <rect width="328" height="274" fill="white"/>
        </clipPath>
      </defs>

      <g clip-path="url(#clip0_509_219)">
        <path d="M81.8486 210.866H317.261C318.609 210.866 319.944 210.6 321.19 210.082C322.435 209.564 323.567 208.806 324.52 207.849C325.473 206.892 326.23 205.757 326.745 204.507C327.261 203.257 327.527 201.917 327.527 200.564V63.9582C327.529 63.0453 327.408 62.1362 327.167 61.2558C326.576 59.0733 325.286 57.1467 323.496 55.7732C321.706 54.3998 319.514 53.6559 317.261 53.6565H225.312C223.167 57.2823 221.845 61.3381 221.44 65.5351C220.3 77.7366 227.271 89.0168 233.51 99.556C239.748 110.095 245.697 122.349 242.394 134.152C240.16 142.112 234.106 147.873 226.595 151.326C219.377 154.531 211.438 155.744 203.597 154.841C198.887 154.244 194.249 153.181 189.748 151.668C183.846 149.744 178.081 147.251 172.326 144.729C172.321 144.729 172.321 144.729 172.316 144.724C172.217 144.681 172.113 144.634 172.013 144.591C167.559 142.639 163.11 140.682 158.595 138.958C153.304 136.882 147.813 135.363 142.209 134.427C133.694 133.088 125.109 133.572 117.512 137.448C105.13 143.76 98.4948 157.401 93.3026 170.329C88.0584 183.4 83.3585 196.907 81.8486 210.866Z" fill="#A36B4C"/>
        <path d="M0.473145 158.607V200.564C0.473072 201.917 0.738553 203.257 1.25444 204.507C1.77033 205.757 2.52652 206.892 3.47982 207.849C4.43311 208.806 5.56485 209.564 6.81041 210.082C8.05597 210.6 9.39095 210.866 10.7391 210.866H49.8719C50.5488 204.535 49.9808 198.228 47.4959 192.343C42.0813 179.51 28.9803 171.92 16.4898 165.826C11.2408 163.266 5.90195 160.797 0.473145 158.607Z" fill="#A36B4C"/>
        <path d="M41.4839 201.177C41.4839 203.909 42.5655 206.53 44.4907 208.462C46.416 210.394 49.0272 211.479 51.7499 211.479H90.8827C91.5595 205.148 90.9915 198.84 88.5067 192.956C87.2337 189.939 84.2601 186.596 80.3854 183.22C65.1837 169.975 41.4839 180.974 41.4839 201.177Z" fill="#A36B4C"/>
        <path d="M0 200.564V63.9582C0.00322699 61.1011 1.13572 58.3619 3.14902 56.3415C5.16232 54.3212 7.89202 53.1848 10.7393 53.1815H317.261C320.108 53.1848 322.838 54.3212 324.851 56.3415C326.864 58.3619 327.997 61.1011 328 63.9582V200.564C327.997 203.421 326.864 206.161 324.851 208.181C322.838 210.201 320.108 211.338 317.261 211.341H10.7393C7.89198 211.338 5.16225 210.201 3.14895 208.181C1.13564 206.161 0.00317812 203.421 0 200.564ZM10.7393 54.1315C8.14297 54.1344 5.65386 55.1706 3.81801 57.0129C1.98216 58.8551 0.949509 61.3529 0.946609 63.9582V200.564C0.949461 203.17 1.98209 205.667 3.81794 207.51C5.65379 209.352 8.14294 210.388 10.7393 210.391H317.261C319.857 210.388 322.346 209.352 324.182 207.51C326.018 205.667 327.051 203.17 327.053 200.564V63.9582C327.05 61.3529 326.018 58.8551 324.182 57.0129C322.346 55.1706 319.857 54.1344 317.261 54.1315H10.7393Z" fill="#3F3D56"/>
        <path d="M101.434 210.529H115.354C117.735 202.485 121.171 193.958 124.309 186.188C130.329 171.29 138.021 155.57 152.376 148.295C158.505 145.189 165.188 143.976 172.013 144.042C181.441 144.132 191.135 146.671 200.009 150.037C203.639 151.411 207.237 152.922 210.819 154.465C224.318 160.286 237.67 166.626 252.186 168.339C270.555 170.506 292.152 162.259 297.169 144.495C300.998 130.895 294.102 116.776 286.87 104.629C279.638 92.483 271.554 79.487 272.874 65.4241C272.879 65.3769 272.884 65.325 272.893 65.2778C273.39 60.2267 276.396 56.5966 280.594 54.2693H262.315C262.074 67.388 269.637 78.9677 276.443 90.4012C283.675 102.543 290.571 116.667 286.742 130.267C281.725 148.026 240.182 127.209 221.813 125.037C216.625 124.428 224.866 126.595 219.92 125.037C212.162 122.597 211.302 144.982 203.753 141.696C199.053 139.647 194.348 137.613 189.582 135.805C187.609 135.054 185.592 134.351 183.552 133.699C183.548 133.699 183.548 133.699 183.543 133.694C169.846 129.342 154.865 127.647 142.209 133.94C142.124 133.982 142.034 134.025 141.949 134.067C127.594 141.337 119.902 157.057 113.882 171.955C108.908 184.272 103.886 197.538 101.434 210.529Z" fill="#3F3D56"/>
        <path d="M101.585 112.616H11.0458C10.3039 112.616 9.5924 112.912 9.06782 113.438C8.54324 113.965 8.24854 114.679 8.24854 115.423C8.24854 116.168 8.54324 116.882 9.06782 117.408C9.5924 117.935 10.3039 118.23 11.0458 118.23H101.585C102.327 118.23 103.038 117.935 103.563 117.408C104.087 116.882 104.382 116.168 104.382 115.423C104.382 114.679 104.087 113.965 103.563 113.438C103.038 112.912 102.327 112.616 101.585 112.616Z" fill="#3F3D56"/>
        <path d="M39.1806 96.8773H11.1088C10.3669 96.8773 9.65541 97.173 9.13082 97.6994C8.60624 98.2258 8.31152 98.9398 8.31152 99.6843C8.31152 100.429 8.60624 101.143 9.13082 101.669C9.65541 102.196 10.3669 102.491 11.1088 102.491H39.1807C39.9225 102.491 40.634 102.196 41.1586 101.669C41.6832 101.143 41.9779 100.429 41.9779 99.6843C41.9779 98.9398 41.6832 98.2258 41.1586 97.6994C40.634 97.173 39.9225 96.8773 39.1806 96.8773Z" fill="#3F3D56"/>
        <path d="M147.433 261.189L141.695 261.14L139.155 238.413L147.624 238.485L147.433 261.189Z" fill="#FFB6B6"/>
        <path d="M129.054 270.345C129.049 271.028 129.314 271.684 129.79 272.171C130.267 272.658 130.917 272.935 131.597 272.942L143.006 273.038L145.003 268.975L145.736 273.058L150.041 273.097L148.954 258.534L147.456 258.434L141.348 258.012L139.377 257.879L139.342 262L130.178 268.237C129.835 268.471 129.553 268.785 129.357 269.152C129.161 269.519 129.057 269.929 129.054 270.345Z" fill="#2F2E41"/>
        <path d="M205.65 261.189L199.911 261.14L197.372 238.413L205.84 238.485L205.65 261.189Z" fill="#FFB6B6"/>
        <path d="M187.27 270.345C187.265 271.028 187.53 271.684 188.007 272.171C188.484 272.658 189.133 272.935 189.813 272.942L201.222 273.038L203.219 268.975L203.953 273.058L208.257 273.097L207.17 258.534L205.673 258.434L199.564 258.012L197.593 257.879L197.559 262L188.394 268.237C188.051 268.471 187.769 268.785 187.574 269.152C187.378 269.519 187.274 269.929 187.27 270.345Z" fill="#2F2E41"/>
        <path d="M140.355 79.1845L166.18 59.2407C167.271 58.3925 167.987 57.1476 168.172 55.7746C168.357 54.4017 167.996 53.0108 167.168 51.9022C166.74 51.3286 166.2 50.8486 165.581 50.4914C164.962 50.1342 164.276 49.9073 163.567 49.8245C162.858 49.7417 162.139 49.8047 161.454 50.0098C160.77 50.2149 160.134 50.5577 159.586 51.0173L133.394 72.5593L116.928 84.9758C116.113 84.5004 115.173 84.2883 114.233 84.3682C113.294 84.4481 112.402 84.8162 111.679 85.4225C110.956 86.0287 110.436 86.8438 110.19 87.7569C109.944 88.6699 109.985 89.6368 110.306 90.5261C110.626 91.4153 111.212 92.1839 111.984 92.7274C112.755 93.2708 113.675 93.5628 114.617 93.5637C115.56 93.5645 116.48 93.2742 117.252 92.7321C118.024 92.1901 118.612 91.4226 118.934 90.5339L140.355 79.1845Z" fill="#FFB6B6"/>
        <path d="M161.403 83.7693L160.265 109.281L198.927 113.976C195.885 103.724 190.896 89.4861 193.182 82.3519L161.403 83.7693Z" fill="#A0616A"/>
        <path d="M183.38 36.9991H171.471L166.356 45.7815L163.919 45.6465C159.17 47.4821 157.276 49.3819 154.655 54.4435L145.444 62.2057L152.543 70.7548C157.447 69.9486 159.215 66.1289 157.658 59.1138C157.658 59.1138 152.288 68.5052 160.023 73.1254C160.023 73.1254 158.644 81.8304 160.023 81.7368C161.403 81.6433 164.581 79.8716 161.403 81.6433C158.225 83.4149 158.77 83.4914 158.873 84.0654C160.59 93.5526 162.009 100.677 162.009 100.677L195.614 104.002C195.614 104.002 193.678 83.6079 193.783 82.4484C193.888 81.2889 193.182 84.1236 193.888 81.289C194.595 78.4543 195.654 79.5173 194.595 78.4543C193.535 77.3913 201.876 76.4759 198.621 71.3676L209.507 68.5179L203.422 54.0055C203.422 49.1055 195.58 45.1332 190.697 45.1332H190.071L183.38 36.9991Z" fill="#E6E6E6"/>
        <path d="M196.053 100.148C182.906 104.686 171.07 103.69 161.063 94.9775C161.063 94.9775 158.246 105.426 155.395 104.002C152.543 102.577 153.952 106.564 153.169 108.026C152.338 109.578 153.303 112.196 150.557 113.086C147.81 113.976 148.842 116.591 147.953 118.516C141.731 131.988 134.625 151.058 129.825 175.245C124.892 200.098 136.924 241.738 136.924 241.738L148.283 240.788L151.123 186.644L164.112 163.757C164.112 163.757 170.493 160.029 166.488 158.138C162.483 156.246 165.166 153.903 168.084 154.362C171.002 154.822 174.315 139.623 174.315 139.623C170.155 150.116 196.087 242.688 196.087 242.688L206.973 241.738L200.82 112.551L196.053 100.148Z" fill="#2F2E41"/>
        <path d="M190.448 14.9507C191.739 18.1772 195.381 24.5223 195.874 27.9836L195.652 27.7645C195.229 28.4906 194.747 29.1812 194.213 29.8295C193.255 28.8201 192.098 28.022 190.816 27.4859C191.516 28.9274 191.922 30.4949 192.009 32.0962C189.638 34.168 183.582 32.918 180.557 34.0222C175.688 35.7948 170.519 36.4258 165.416 36.9499C163.604 37.137 161.576 37.2506 160.307 36.1764C159.037 35.1023 159.793 33.113 159.11 31.6084C154.245 20.8913 158.735 17.0247 162.55 12.1651C163.389 11.0957 163.385 9.49985 164.407 8.4795C165.824 7.06519 167.997 6.63017 170 6.2817C169.479 6.30921 168.961 6.20185 168.494 5.96996C168.027 5.73806 167.627 5.38944 167.333 4.95766C167.076 4.52263 166.942 4.02462 166.949 3.51856C166.955 3.01249 167.101 2.51803 167.37 2.08972C168.086 0.897981 169.574 0.204972 171.01 0.0318468C172.425 -0.064563 173.847 0.0580298 175.224 0.395324C176.117 0.513107 176.981 0.790285 177.776 1.21374C178.151 1.41458 178.456 1.72555 178.65 2.10507C178.845 2.48458 178.919 2.91456 178.863 3.33753C178.743 3.72812 178.537 4.08656 178.26 4.38611C177.983 4.68567 177.643 4.91861 177.263 5.06758C176.685 5.31287 176.077 5.47992 175.455 5.56434C178.312 5.19227 181.215 5.70205 183.776 7.02586C186.986 8.74416 189.152 11.726 190.448 14.9507Z" fill="#2F2E41"/>
        <path d="M173.066 33.0397C179.404 33.0397 184.541 27.8843 184.541 21.5249C184.541 15.1654 179.404 10.0101 173.066 10.0101C166.729 10.0101 161.591 15.1654 161.591 21.5249C161.591 27.8843 166.729 33.0397 173.066 33.0397Z" fill="#FFB6B6"/>
        <path d="M184.108 15.3508C183.442 17.3686 181.541 18.0188 179.784 18.4244C179.23 18.554 178.672 18.6747 178.109 18.7822C177.902 18.5217 177.681 18.2665 177.45 18.0252C176.493 17.0158 175.336 16.2177 174.054 15.6816C174.608 16.8202 174.977 18.0409 175.145 19.2969C174.083 19.4516 173.014 19.578 171.94 19.6761C171.031 19.8702 170.083 19.7065 169.291 19.2189C168.499 18.7313 167.924 17.957 167.685 17.056C166.707 18.6607 165.551 20.1719 163.97 20.8093C163.066 21.1353 162.081 21.1621 161.161 20.8858C160.24 20.6094 159.432 20.0445 158.855 19.2738C157.908 18.1145 157.381 16.5571 157.001 15.054C156.552 13.2671 156.303 11.2088 157.184 10.0751C157.89 9.15752 159.108 9.14104 160.231 9.22245C162.71 9.41331 165.164 9.85963 167.552 10.5544L167.754 11.0106C167.344 8.53609 168.234 6.15531 169.881 5.30862C170.993 4.74251 172.329 4.83743 173.628 4.95228C175.297 5.02698 176.945 5.34689 178.521 5.90179C180.329 6.59962 181.878 7.84092 182.956 9.45587C184.109 11.2125 184.681 13.6083 184.108 15.3508Z" fill="#2F2E41"/>
        <path d="M167.749 4.58849C167.863 4.55495 167.569 4.59803 167.671 4.60077C167.621 4.59783 167.57 4.59077 167.521 4.57967C167.513 4.57798 167.398 4.5414 167.474 4.56827C167.304 4.51713 167.152 4.41758 167.036 4.28162C166.767 3.94713 166.555 3.56947 166.411 3.16448C166.229 2.6293 165.935 2.13886 165.551 1.72537C165.442 1.61535 165.308 1.53271 165.161 1.48416C165.014 1.43561 164.858 1.42251 164.705 1.44594C164.552 1.46936 164.407 1.52865 164.281 1.61899C164.155 1.70932 164.052 1.82815 163.981 1.96584C163.758 2.46191 163.962 3.07313 164.121 3.56035C164.285 4.06658 164.53 4.54287 164.846 4.97086C165.375 5.67074 166.095 6.2011 166.919 6.49732C167.873 6.84495 168.913 6.87478 169.885 6.58237C170.014 6.52891 170.124 6.43912 170.202 6.32394C170.281 6.20877 170.324 6.07318 170.327 5.93369C170.33 5.7942 170.293 5.65683 170.219 5.53833C170.146 5.41983 170.04 5.3253 169.914 5.26627L168.293 4.60037C168.207 4.56269 168.115 4.54224 168.022 4.5402C167.929 4.53816 167.836 4.55458 167.749 4.58849C167.663 4.6224 167.583 4.67313 167.516 4.73783C167.448 4.80253 167.394 4.87991 167.357 4.96555C167.319 5.05118 167.299 5.1434 167.297 5.23694C167.295 5.33048 167.311 5.4235 167.345 5.5107C167.379 5.5979 167.429 5.67756 167.494 5.74515C167.558 5.81273 167.635 5.86691 167.721 5.90459L169.342 6.57047L169.371 5.25438C169.168 5.31297 168.96 5.34868 168.75 5.36085C168.526 5.38339 168.299 5.37382 168.078 5.33241C167.866 5.30449 167.657 5.25346 167.456 5.18022C167.327 5.13299 167.201 5.07923 167.077 5.01915C167.032 4.9973 166.988 4.97462 166.944 4.9511C166.947 4.9528 166.758 4.84258 166.841 4.89437C166.632 4.75991 166.435 4.60613 166.254 4.43503C166.19 4.37436 166.131 4.30853 166.077 4.23822C165.985 4.12436 165.899 4.00519 165.821 3.88131C165.661 3.61897 165.535 3.33769 165.444 3.04396C165.403 2.92051 165.368 2.795 165.34 2.66792C165.332 2.59816 165.32 2.52903 165.302 2.46099C165.242 2.29888 165.314 2.55565 165.245 2.62589L164.946 2.84687C164.89 2.86364 164.831 2.86754 164.773 2.85824C164.715 2.84895 164.66 2.82672 164.612 2.7932C164.576 2.74321 164.584 2.7515 164.635 2.81808C164.694 2.89644 164.748 2.97848 164.797 3.06373C164.904 3.2644 165.001 3.47041 165.088 3.68094C165.266 4.1287 165.491 4.55607 165.76 4.95578C166.024 5.36006 166.408 5.67059 166.857 5.8431C167.307 6.01561 167.799 6.04129 168.264 5.91649C168.439 5.84677 168.579 5.71101 168.654 5.53848C168.73 5.36596 168.735 5.1705 168.668 4.99429C168.597 4.82063 168.462 4.68138 168.29 4.60574C168.119 4.53009 167.925 4.52391 167.749 4.58849Z" fill="#2F2E41"/>
        <path d="M149.853 129.694C168.591 129.694 183.782 114.451 183.782 95.6469C183.782 76.8432 168.591 61.5998 149.853 61.5998C131.114 61.5998 115.924 76.8432 115.924 95.6469C115.924 114.451 131.114 129.694 149.853 129.694Z" fill="white"/>
        <path d="M149.852 130.169C143.048 130.169 136.397 128.144 130.74 124.351C125.082 120.558 120.673 115.166 118.069 108.858C115.465 102.55 114.784 95.6088 116.111 88.9121C117.439 82.2155 120.715 76.0643 125.526 71.2363C130.337 66.4083 136.467 63.1204 143.141 61.7883C149.814 60.4562 156.731 61.1398 163.017 63.7527C169.304 66.3656 174.676 70.7903 178.457 76.4674C182.237 82.1445 184.254 88.8189 184.255 95.6468C184.244 104.799 180.616 113.574 174.167 120.046C167.718 126.518 158.973 130.159 149.852 130.169ZM149.852 62.0749C143.235 62.0749 136.767 64.0438 131.265 67.7328C125.764 71.4217 121.476 76.665 118.943 82.7995C116.411 88.9341 115.749 95.6843 117.04 102.197C118.331 108.709 121.517 114.691 126.196 119.386C130.875 124.081 136.836 127.279 143.326 128.574C149.815 129.869 156.542 129.205 162.655 126.664C168.769 124.122 173.994 119.819 177.67 114.298C181.346 108.778 183.308 102.287 183.308 95.6468C183.298 86.746 179.77 78.2127 173.498 71.9189C167.226 65.6251 158.722 62.0849 149.852 62.0749Z" fill="#3F3D56"/>
        <path d="M145.224 113.367C144.638 113.367 144.06 113.23 143.536 112.967C143.012 112.704 142.556 112.322 142.205 111.852L132.949 99.4666C132.651 99.0687 132.435 98.616 132.312 98.1342C132.189 97.6524 132.162 97.151 132.232 96.6587C132.302 96.1664 132.468 95.6927 132.72 95.2647C132.973 94.8368 133.307 94.463 133.704 94.1646C134.1 93.8662 134.551 93.6491 135.031 93.5257C135.511 93.4023 136.011 93.375 136.502 93.4453C136.992 93.5157 137.464 93.6823 137.891 93.9357C138.317 94.1891 138.69 94.5243 138.987 94.9222L145.043 103.024L160.596 79.6128C160.871 79.199 161.225 78.8436 161.637 78.5668C162.048 78.2901 162.511 78.0974 162.997 77.9999C163.483 77.9023 163.983 77.9018 164.469 77.9983C164.955 78.0949 165.418 78.2865 165.83 78.5624C166.243 78.8383 166.597 79.193 166.873 79.6062C167.149 80.0195 167.34 80.4832 167.438 80.9709C167.535 81.4586 167.535 81.9607 167.439 82.4487C167.343 82.9366 167.152 83.4007 166.877 83.8145L148.364 111.68C148.03 112.184 147.579 112.6 147.051 112.893C146.523 113.187 145.932 113.349 145.329 113.366C145.294 113.366 145.259 113.367 145.224 113.367Z" fill="#94B949"/>
        <path d="M112.48 273.435C112.48 273.509 112.494 273.583 112.522 273.651C112.551 273.72 112.592 273.782 112.644 273.835C112.697 273.887 112.759 273.929 112.827 273.957C112.896 273.986 112.969 274 113.043 274H232.927C233.076 274 233.219 273.94 233.325 273.834C233.43 273.728 233.49 273.585 233.49 273.435C233.49 273.285 233.43 273.141 233.325 273.035C233.219 272.929 233.076 272.87 232.927 272.87H113.043C112.969 272.869 112.896 272.884 112.827 272.912C112.759 272.941 112.697 272.982 112.644 273.035C112.592 273.087 112.551 273.15 112.522 273.218C112.494 273.287 112.48 273.361 112.48 273.435Z" fill="#CCCCCC"/>
        <path d="M218.624 96.8114L207.533 66.0631C207.06 64.7618 206.095 63.6996 204.848 63.1057C203.6 62.5117 202.17 62.4338 200.866 62.8885C200.192 63.1238 199.572 63.4945 199.045 63.978C198.517 64.4615 198.094 65.0476 197.8 65.7007C197.506 66.3539 197.347 67.0602 197.334 67.7768C197.321 68.4934 197.453 69.2052 197.723 69.8688L210.22 101.454L217.007 120.968C216.308 121.603 215.821 122.438 215.611 123.36C215.402 124.282 215.481 125.247 215.836 126.122C216.192 126.998 216.808 127.743 217.601 128.255C218.393 128.767 219.323 129.022 220.265 128.986C221.207 128.949 222.114 128.622 222.865 128.05C223.615 127.477 224.171 126.687 224.459 125.786C224.746 124.885 224.749 123.918 224.469 123.015C224.189 122.112 223.639 121.317 222.893 120.739L218.624 96.8114Z" fill="#FFB6B6"/>
        <path d="M201.934 52.3695L210.927 68.5179C210.927 68.5179 190.202 75.6385 190.152 74.4529C190.101 73.2674 191.181 56.8161 191.181 56.8161L201.934 52.3695Z" fill="#E6E6E6"/>
      </g>
    </svg>

    ''';
  }
}