import QtQuick 1.1

XmlListModel{
//    source: "http://m2m1.inner-active.com/simpleM2M/clientRequestAd?aid=Geronik_FindDifferences_OVI&po=551&v=Sm2m-1.5.3&w=240&h=320"
//    query: "/Response/Ad"
//    namespaceDeclarations: "declare namespace tns='http://www.inner-active.com/SimpleM2M/M2MResponse http://www.inner-active.com/Public/XML/SimpleM2M/M2MResponse.xsd ';"

//    XmlRole { name: "url"; query: "URL/string()" }
//    XmlRole { name: "icon"; query: "Image/string()" }

    source: "http://m2m1.inner-active.com/simpleM2M/clientRequestHtmlAd?aid=Geronik_FindDifferences_OVI&po=551&v=Sm2m-1.5.3&w=320&h=240"
    query: "/a"

    XmlRole { name: "url"; query: "@href/string()" }
    XmlRole { name: "icon"; query: "img/@src/string()" }
    XmlRole { name: "alt"; query: "img/@alt/string()" }
}
