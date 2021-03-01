/*
 * Product by Swing Technologies.
 * Copyright (c) 1/3/2021.
 * Developed by Debojyoti Singha
 */

class RouteArgument {
  String id;
  String heroTag;
  Map<String, dynamic> params;

  RouteArgument({this.id, this.heroTag, this.params});

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
