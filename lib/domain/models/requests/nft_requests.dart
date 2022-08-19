class GetNFTListRequest {
  String chain;
  String? continuation;
  String? include;
  int? pageSize;

  GetNFTListRequest({
    this.chain = 'ethereum',
    this.continuation,
    this.include = 'all',
    this.pageSize = 10,
  });

  Map<String, dynamic> queryParams() => {
    'chain': chain,
    'continuation': continuation,
    'include': include,
    'page_size': pageSize,
  };
}