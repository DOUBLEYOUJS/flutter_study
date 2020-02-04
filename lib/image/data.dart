class BannerItem {
    String bannerId;
    String encodeId;
    bool exclusive;
    String pic;
    bool showAdTag;
    int targetId;
    int targetType;
    String titleColor;
    String typeTitle;

    BannerItem({this.bannerId, this.encodeId, this.exclusive, this.pic, this.showAdTag, this.targetId, this.targetType, this.titleColor, this.typeTitle});

    factory BannerItem.fromJson(Map<String, dynamic> json) {
        return BannerItem(
            bannerId: json['bannerId'],
            encodeId: json['encodeId'],
            exclusive: json['exclusive'],
            pic: json['pic'],
            showAdTag: json['showAdTag'],
            targetId: json['targetId'],
            targetType: json['targetType'],
            titleColor: json['titleColor'],
            typeTitle: json['typeTitle'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bannerId'] = this.bannerId;
        data['encodeId'] = this.encodeId;
        data['exclusive'] = this.exclusive;
        data['pic'] = this.pic;
        data['showAdTag'] = this.showAdTag;
        data['targetId'] = this.targetId;
        data['targetType'] = this.targetType;
        data['titleColor'] = this.titleColor;
        data['typeTitle'] = this.typeTitle;
        return data;
    }

    @override
    String toString() {
        return 'BannerItem{bannerId: $bannerId, encodeId: $encodeId, exclusive: $exclusive, pic: $pic, showAdTag: $showAdTag, targetId: $targetId, targetType: $targetType, titleColor: $titleColor, typeTitle: $typeTitle}';
    }


}

class BannerWarp {
    List<BannerItem> banners;
    int code;

    BannerWarp({this.banners, this.code});

    factory BannerWarp.fromJson(Map<String, dynamic> json) {
        return BannerWarp(
            banners: json['banners'] != null ? (json['banners'] as List).map((i) => BannerItem.fromJson(i)).toList() : null,
            code: json['code'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        if (this.banners != null) {
            data['banners'] = this.banners.map((v) => v.toJson()).toList();
        }
        return data;
    }
}