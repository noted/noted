// ligature.js v1.0
// http://code.google.com/p/ligature-js/
ligature = function(extended, node) {
    if (!node) {
        ligature(extended, document.body);
    }
    else {
        if (node.nodeType == 3 && node.parentNode.nodeName != 'SCRIPT') {
            node.nodeValue = node.nodeValue
                .replace(/ffl/g, 'ﬄ')
                .replace(/ffi/g, 'ﬃ')
                .replace(/fl/g, 'ﬂ')
                .replace(/fi/g, 'ﬁ')
                .replace(/ff/g, 'ﬀ')
                .replace(/ij/g, 'ĳ')
                .replace(/IJ/g, 'Ĳ');
                
            if (extended) {
                node.nodeValue = node.nodeValue
                    .replace(/ae/g, 'æ')
                    .replace(/A[Ee]/g, 'Æ')
                    .replace(/oe/g, 'œ')
                    .replace(/O[Ee]/g, 'Œ')
                    .replace(/ue/g, 'ᵫ')
                    .replace(/st/g, 'ﬆ');
            }
        }
        if (node.childNodes) {
            for (var i=0; i < node.childNodes.length; i++) {
                ligature(extended, node.childNodes.item(i));
            }
        }
    }
};
