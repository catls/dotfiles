(function () {
    var hintKey   = 'P';
    var hintXPath = '//div[@class="works_display"]//img | //div[@class="pixiv-dashboard-div"]//img';
    hints.addMode(
        hintKey,
        'Pixiv Bookmark',
        function (elem) {
            var tombloo = Cc['@tombfix.github.io/tombfix-service;1'] || Cc['@brasil.to/tombloo-service;1'];
            var tomblooService = tombloo.getService().wrappedJSObject.Tombloo.Service;

            var d = window.content.document;
            var w = window.content.wrappedJSObject;
            var context = {
                document: d,
                window:   w,
                title:    d.title,
                target:   elem,
            };
            for (let p in w.location) {
                context[p] = w.location[p];
            }

            var extractors = tomblooService.check(context);
            var string = 'Photo - pixiv (with *Tags)';
            var extractor;
            for (let i = 0; i < extractors.length; i++) {
                if (extractors[i].name == string) {
                    extractor = extractors[i];
                    break;
                }
            }
            if (!extractor) return;
            tomblooService.share(context, extractor,false);
        },
        function () hintXPath
    );
})();
