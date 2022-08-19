class NFTMetadata {
    NFTMetadata({
        this.description,
        this.backgroundColor,
        this.externalUrl,
        this.image,
        this.name,
        this.animationUrl,
    });

    String? description;
    String? backgroundColor;
    String? externalUrl;
    String? image;
    String? name;
    String? animationUrl;

    factory NFTMetadata.fromJson(dynamic json) => NFTMetadata(
        description: json["description"],
        backgroundColor: json["background_color"],
        externalUrl: json["external_url"],
        image: json["image"],
        name: json["name"],
        animationUrl: json["animation_url"],
    );
}