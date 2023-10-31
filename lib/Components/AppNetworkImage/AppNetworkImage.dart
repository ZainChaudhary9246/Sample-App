import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../Utils/Constants/AssetsImage.dart';

Widget appNetworkImage(String? url, double? width, double? height, BoxFit boxFit,
    {Color? imageColor,
    Color? svgColor,
    bool showLoadingShimmers = true,
    bool showLoading = true,
    bool showErrorWidget = true,
    Color? svgBackgroundColor,
    Alignment alignment = Alignment.center,
    BoxFit? svgBoxFit}) {
  String imageType = url != null && url.isNotEmpty ? url.substring(url.length - 3) : "";

  return (url != null && url.isNotEmpty && url.length > 4)
      ? url.substring(url.length - 3) == 'svg'
          ? Material(
              color: svgBackgroundColor ?? Colors.transparent,
              child: SvgPicture.network(url ?? "",
                  fit: svgBoxFit ?? boxFit,
                  width: width,
                  alignment: alignment,
                  color: svgColor,
                  height: height,
                  placeholderBuilder: (BuildContext context) => showLoadingShimmers
                      ? Shimmer.fromColors(
                          direction: ShimmerDirection.ltr,
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey,
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.grey,
                            child: Text(
                              " KeysConstant.appName",
                            ),
                          ),
                        )
                      : Center(child: CircularProgressIndicator())),
            )
          : CachedNetworkImage(
              fit: boxFit,
              imageUrl: url ?? "",
              width: width,
              alignment: alignment,
              color: imageColor,
              height: height,
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return showLoading
                    ? showLoadingShimmers
                        ? Shimmer.fromColors(
                            direction: ShimmerDirection.ltr,
                            baseColor: Colors.grey[400]!,
                            highlightColor: Colors.grey,
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.grey,
                              child: Text(
                                " KeysConstant.appName",
                              ),
                            ),
                          )
                        : Center(child: CircularProgressIndicator())
                    : SizedBox();
              },
              errorWidget: (context, url, error) => showErrorWidget
                  ? Image.asset(
                      AssetsImages.noImage,
                      height: height,
                      width: width,
                    )
                  : SizedBox(),
            )
      : SizedBox();
}
