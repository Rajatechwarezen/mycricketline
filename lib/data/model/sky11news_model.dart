class Sky11 {
  int? id;
  DateTime? date;
  DateTime? dateGmt;
  Guid? guid;
  DateTime? modified;
  DateTime? modifiedGmt;
  String? slug;
  String? status;
  String? type;
  String? link;
  
  Guid? title;
  Content? content;
  Content? excerpt;
  int? author;
  int? featuredMedia;
  String? commentStatus;
  String? pingStatus;
  bool? sticky;
  String? template;
  String? format;
  Meta? meta;
  List<int>? categories;
  List<int>? tags;
  bool? ampEnabled;
  Links? links;

  Sky11({
    this.id,
    this.date,
    this.dateGmt,
    this.guid,
    this.modified,
    this.modifiedGmt,
    this.slug,
    this.status,
    this.type,
    this.link,
    this.title,
    this.content,
    this.excerpt,
    this.author,
    this.featuredMedia,
    this.commentStatus,
    this.pingStatus,
    this.sticky,
    this.template,
    this.format,
    this.meta,
    this.categories,
    this.tags,
    this.ampEnabled,
    this.links,
  });

  factory Sky11.fromJson(Map<String, dynamic> json) {
    return Sky11(
      id: json['id'],
      date: DateTime.tryParse(json['date']),
      dateGmt: DateTime.tryParse(json['date_gmt']),
      guid: Guid.fromJson(json['guid']),
      modified: DateTime.tryParse(json['modified']),
      modifiedGmt: DateTime.tryParse(json['modified_gmt']),
      slug: json['slug'],
      status: json['status'],
      type: json['type'],
      link: json['link'],
      title: Guid.fromJson(json['title']),
      content: Content.fromJson(json['content']),
      excerpt: Content.fromJson(json['excerpt']),
      author: json['author'],
      featuredMedia: json['featured_media'],
      commentStatus: json['comment_status'],
      pingStatus: json['ping_status'],
      sticky: json['sticky'],
      template: json['template'],
      format: json['format'],
      meta: Meta.fromJson(json['meta']),
      categories: (json['categories'] as List?)?.map((e) => e as int).toList(),
      tags: (json['tags'] as List?)?.map((e) => e as int).toList(),
      ampEnabled: json['amp_enabled'],
      links: Links.fromJson(json['_links']),
    );
  }
}

class Content {
  String? rendered;
  bool? protected;

  Content({
    this.rendered,
    this.protected,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      rendered: json['rendered'],
      protected: json['protected'],
    );
  }
}

class Guid {
  String? rendered;

  Guid({
    this.rendered,
  });

  factory Guid.fromJson(Map<String, dynamic> json) {
    return Guid(
      rendered: json['rendered'],
    );
  }
}

class Links {
  List<About>? self;
  List<About>? collection;
  List<About>? about;
  List<Author>? author;
  List<Author>? replies;
  List<VersionHistory>? versionHistory;
  List<PredecessorVersion>? predecessorVersion;
  List<Author>? wpFeaturedmedia;
  List<About>? wpAttachment;
  List<WpTerm>? wpTerm;
  List<Cury>? curies;

  Links({
    this.self,
    this.collection,
    this.about,
    this.author,
    this.replies,
    this.versionHistory,
    this.predecessorVersion,
    this.wpFeaturedmedia,
    this.wpAttachment,
    this.wpTerm,
    this.curies,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: (json['self'] as List?)?.map((e) => About.fromJson(e)).toList(),
      collection: (json['collection'] as List?)?.map((e) => About.fromJson(e)).toList(),
      about: (json['about'] as List?)?.map((e) => About.fromJson(e)).toList(),
      author: (json['author'] as List?)?.map((e) => Author.fromJson(e)).toList(),
      replies: (json['replies'] as List?)?.map((e) => Author.fromJson(e)).toList(),
      versionHistory: (json['version_history'] as List?)?.map((e) => VersionHistory.fromJson(e)).toList(),
      predecessorVersion: (json['predecessor_version'] as List?)?.map((e) => PredecessorVersion.fromJson(e)).toList(),
      wpFeaturedmedia: (json['wp:featuredmedia'] as List?)?.map((e) => Author.fromJson(e)).toList(),
      wpAttachment: (json['wp:attachment'] as List?)?.map((e) => About.fromJson(e)).toList(),
      wpTerm: (json['wp:term'] as List?)?.map((e) => WpTerm.fromJson(e)).toList(),
      curies: (json['curies'] as List?)?.map((e) => Cury.fromJson(e)).toList(),
    );
  }
}

class About {
  String? href;

  About({
    this.href,
  });

  factory About.fromJson(Map<String, dynamic> json) {
    return About(
      href: json['href'],
    );
  }
}

class Author {
  bool? embeddable;
  String? href;

  Author({
    this.embeddable,
    this.href,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      embeddable: json['embeddable'],
      href: json['href'],
    );
  }
}

class Cury {
  String? name;
  String? href;
  bool? templated;

  Cury({
    this.name,
    this.href,
    this.templated,
  });

  factory Cury.fromJson(Map<String, dynamic> json) {
    return Cury(
      name: json['name'],
      href: json['href'],
      templated: json['templated'],
    );
  }
}

class PredecessorVersion {
  int? id;
  String? href;

  PredecessorVersion({
    this.id,
    this.href,
  });

  factory PredecessorVersion.fromJson(Map<String, dynamic> json) {
    return PredecessorVersion(
      id: json['id'],
      href: json['href'],
    );
  }
}

class VersionHistory {
  int? count;
  String? href;

  VersionHistory({
    this.count,
    this.href,
  });

  factory VersionHistory.fromJson(Map<String, dynamic> json) {
    return VersionHistory(
      count: json['count'],
      href: json['href'],
    );
  }
}

class WpTerm {
  String? taxonomy;
  bool? embeddable;
  String? href;

  WpTerm({
    this.taxonomy,
    this.embeddable,
    this.href,
  });

  factory WpTerm.fromJson(Map<String, dynamic> json) {
    return WpTerm(
      taxonomy: json['taxonomy'],
      embeddable: json['embeddable'],
      href: json['href'],
    );
  }
}

class Meta {
  String? footnotes;

  Meta({
    this.footnotes,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      footnotes: json['footnotes'],
    );
  }
}











class Sky111 {
  int? id;

  Guid4? guid;
 

  Sky111({
    this.id,
   
    this.guid,
  
  });

  factory Sky111.fromJson(Map<String, dynamic> json) {
    return Sky111(
      id: json['id'],
    
       guid: Guid4.fromJson(json['guid']),
        );
  }
}

class Guid4 {
  String? rendered;

  Guid4({
    this.rendered,
  });

  factory Guid4.fromJson(Map<String, dynamic> json) {
    return Guid4(
      rendered: json['rendered'],
    );
  }
}
