#!/bin/sh
set -e

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "cp -fpR ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      cp -fpR "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo xcrun momc "${PODS_ROOT}/$1" ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom
      xcrun momc "${PODS_ROOT}/$1" ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom
      ;;
    *.xcdatamodeld)
      echo  xcrun momc "${PODS_ROOT}/$1" ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd
      xcrun momc "${PODS_ROOT}/$1" ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconAction.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconAction@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconAdd.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconAdd@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconBookmarks.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconBookmarks@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconCamera.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconCamera@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconCompose.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconCompose@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconFastForward.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconFastForward@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconOrganize.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconOrganize@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconPause.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconPause@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconPlay.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconPlay@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconRefresh.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconRefresh@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconReply.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconReply@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconRewind.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconRewind@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconSearch.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconSearch@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconStop.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconStop@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconTrash.png'
install_resource 'UI7Kit/Resources/UI7BarButtonItemIconTrash@2x.png'
install_resource 'UI7Kit/Resources/UI7ButtonImageAdd.png'
install_resource 'UI7Kit/Resources/UI7ButtonImageAdd@2x.png'
install_resource 'UI7Kit/Resources/UI7ButtonImageInfo.png'
install_resource 'UI7Kit/Resources/UI7ButtonImageInfo@2x.png'
install_resource 'UI7Kit/Resources/UI7NavigationBarBackButton.png'
install_resource 'UI7Kit/Resources/UI7NavigationBarBackButton@2x.png'
install_resource 'UI7Kit/Resources/UI7SliderThumb.png'
install_resource 'UI7Kit/Resources/UI7SliderThumb@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemBookmarksUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemBookmarksUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemContactsUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemContactsUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemDownloadsUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemDownloadsUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemFavoriteSelected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemFavoriteSelected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemFavoriteUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemFavoriteUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemHistoryUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemHistoryUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMoreUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMoreUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMostRecentUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMostRecentUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMostViewedUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMostViewedUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemSearchUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemSearchUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemBookmarksUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemBookmarksUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemContactsUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemContactsUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemDownloadsUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemDownloadsUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemFavoriteSelected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemFavoriteSelected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemFavoriteUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemFavoriteUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemHistoryUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemHistoryUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMoreUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMoreUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMostRecentUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMostRecentUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMostViewedUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMostViewedUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemSearchUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemSearchUnselected@2x.png'

rsync -avr --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rm -f "$RESOURCES_TO_COPY"
