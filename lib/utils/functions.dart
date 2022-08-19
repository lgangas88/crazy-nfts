final _videoExtensions = ['mp4'];

bool isUrlVideo(String url) {
  final splittedUrl = url.split('.');
  return splittedUrl.isNotEmpty
      ? _videoExtensions.contains(splittedUrl.last)
      : false;
}
