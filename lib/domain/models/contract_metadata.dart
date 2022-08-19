class ContractMetadata {
  ContractMetadata({
    this.description,
    this.thumbnailUrl,
    this.cachedThumbnailUrl,
    this.bannerUrl,
    this.cachedBannerUrl,
  });

  String? description;
  String? thumbnailUrl;
  String? cachedThumbnailUrl;
  String? bannerUrl;
  String? cachedBannerUrl;

  factory ContractMetadata.fromJson(dynamic json) =>
      ContractMetadata(
        description: json["description"],
        thumbnailUrl: json["thumbnail_url"],
        cachedThumbnailUrl: json["cached_thumbnail_url"],
        bannerUrl: json["banner_url"],
        cachedBannerUrl: json["cached_banner_url"],
      );
}
