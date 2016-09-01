// ========================== KeySnail Init File =========================== //

// この領域は, GUI により設定ファイルを生成した際にも引き継がれます
// 特殊キー, キーバインド定義, フック, ブラックリスト以外のコードは, この中に書くようにして下さい
// ========================================================================= //
//{{%PRESERVE%
/** ldrnailはpixivだけ、かつsiteinfoを独自のものを使用する**/
plugins.options["ldrnail.exclude_urls"] = [
    '.*',
];
plugins.options["ldrnail.include_urls"] = [
    /* pixiv フォロー新着作品 */
    '^http://www\\.pixiv\\.net/bookmark_new_illust\\.php',
    /* pixiv ユーザ作品一覧 */
    '^http://www\\.pixiv\\.net/member_illust\\.php\\?id=\\d+',
    /* pixiv ブックマーク一覧 */
    '^http://www\\.pixiv\\.net/bookmark\\.php',
    /* pixiv 検索結果一覧 */
    '^http://www\\.pixiv\\.net/search\\.php',
];
plugins.options["ldrnail.siteinfo_urls"] = [
    null,
]
plugins.options["ldrnail.siteinfo"] = [
    {
        name       : 'pixiv dsbder',
        domain     : "^http://www\\.pixiv\\.net/.*",
        paragraph  : "//li[contains(concat(' ',normalize-space(@class),' '),' pixiv-dashboard-li ')]",
        link       : "a",
        exampleUrl : 'www.pixiv.net',
    },
    {
        name       : 'pixiv フォロー新着作品',
        domain     : '^http://www\\.pixiv\\.net/bookmark_new_illust\\.php',
        paragraph  : "//li[./a[contains(concat(' ',@class,' '),' work ')]]",
        link       : "a",
        exampleUrl : 'http://www.pixiv.net/bookmark_new_illust.php',
    },
    {
        name       : 'pixiv ユーザ作品一覧',
        domain     : '^http://www\\.pixiv\\.net/member_illust\\.php\\?id=\\d+',
        paragraph  : "//li[contains(concat(' ',normalize-space(@class),' '),' image-item ')]",
        link       : "a",
        exampleUrl : 'http://www.pixiv.net/member_illust.php?id=123456',
    },
    {
        name       : 'pixiv ブックマーク一覧',
        domain     : '^http://www\\.pixiv\\.net/bookmark\\.php.*',
        paragraph  : "//li[./a[contains(concat(' ',@class,' '),' work ')]]",
        link       : "a",
        exampleurl : 'http://www.pixiv.net/bookmark.php',
    },
    {
        name       : 'pixiv 検索結果一覧',
        domain     : '^http://www\\.pixiv\\.net/search\\.php.*',
        paragraph  : "//li[./a[contains(concat(' ',@class,' '),' work ')]]",
        link       : "a",
        exampleUrl : 'http://www.pixiv.net/search.php?s_mode=s_tag&word=オリジナル'
    },
    {
        name       : 'pixiv スタックフィード',
        domain     : "^http://www\\.pixiv\\.net/stacc/(my/home/(all|mypixiv|favorite|self)/(all|messege_from))?",
        paragraph  : '//div[@id="stacc_timeline"]/div',
        link       : ".//div[contains(concat(' ',normalize-space(@class),' '),' stacc_ref_illust_img ')]/a",
        exampleUrl : 'www.pixiv.net/stacc/?mode=unify',
    },
];
plugins.options["ldrnail.keybind"] = {
    "k" : 'prev',"p" : 'pin', "v" : 'view', "o" : 'open', 'l': 'list', 's': 'siteinfo',
    "j" : function() {
        var siteinfo = plugins.ldrnail.currentSiteinfo;
        var currentItem = plugins.ldrnail.currentItem;
        if(siteinfo['name'] === 'pixiv dsbder' && currentItem){
            var match = currentItem.className.match(/illust-(\d+)/);
            if(match){
                var url = "http://alice/Pixiv/checkRead.php?type=read&illustId="+match[1];
                var xhr = new XMLHttpRequest();
                xhr.open("GET",url,true);
                xhr.send(null);
            }
        }
        plugins.ldrnail.next();
    },
};
//}}%PRESERVE%
// ========================================================================= //

// ========================= Special key settings ========================== //

key.quitKey              = "undefined";
key.helpKey              = "undefined";
key.escapeKey            = "undefined";
key.macroStartKey        = "undefined";
key.macroEndKey          = "undefined";
key.universalArgumentKey = "undefined";
key.negativeArgument1Key = "undefined";
key.negativeArgument2Key = "undefined";
key.negativeArgument3Key = "undefined";
key.suspendKey           = "undefined";

// ================================= Hooks ================================= //




// ============================= Key bindings ============================== //
