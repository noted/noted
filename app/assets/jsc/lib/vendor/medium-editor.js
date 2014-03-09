function MediumEditor(a,b){"use strict";return this.init(a,b)}"object"==typeof module&&(module.exports=MediumEditor),function(a,b){"use strict";function c(a,b){var c;if(void 0===a)return b;for(c in b)b.hasOwnProperty(c)&&a.hasOwnProperty(c)===!1&&(a[c]=b[c]);return a}function d(){var b,c,d,e=a.getSelection();if(e.getRangeAt&&e.rangeCount){for(d=[],b=0,c=e.rangeCount;c>b;b+=1)d.push(e.getRangeAt(b));return d}return null}function e(b){var c,d,e=a.getSelection();if(b)for(e.removeAllRanges(),c=0,d=b.length;d>c;c+=1)e.addRange(b[c])}function f(){var a=b.getSelection().anchorNode,c=a&&3===a.nodeType?a.parentNode:a;return c}function g(){var c,d,e,f,g="";if(void 0!==a.getSelection){if(d=a.getSelection(),d.rangeCount){for(f=b.createElement("div"),c=0,e=d.rangeCount;e>c;c+=1)f.appendChild(d.getRangeAt(c).cloneContents());g=f.innerHTML}}else void 0!==b.selection&&"Text"===b.selection.type&&(g=b.selection.createRange().htmlText);return g}MediumEditor.prototype={defaults:{allowMultiParagraphSelection:!0,anchorInputPlaceholder:"Paste or type a link",buttons:["bold","italic","underline","anchor","header1","header2","quote"],buttonLabels:!1,delay:0,diffLeft:0,diffTop:-10,disableReturn:!1,disableToolbar:!1,firstHeader:"h3",forcePlainText:!0,placeholder:"Type your text",secondHeader:"h4",targetBlank:!1,anchorPreviewHideDelay:500},isIE:"Microsoft Internet Explorer"===navigator.appName||"Netscape"===navigator.appName&&null!==new RegExp("Trident/.*rv:([0-9]{1,}[.0-9]{0,})").exec(navigator.userAgent),init:function(a,d){return this.elements="string"==typeof a?b.querySelectorAll(a):a,0!==this.elements.length?(this.isActive=!0,this.parentElements=["p","h1","h2","h3","h4","h5","h6","blockquote","pre"],this.id=b.querySelectorAll(".medium-editor-toolbar").length+1,this.options=c(d,this.defaults),this.initElements().bindSelect().bindPaste().setPlaceholders().bindWindowActions()):void 0},initElements:function(){var a,b=!1;for(a=0;a<this.elements.length;a+=1)this.elements[a].setAttribute("contentEditable",!0),this.elements[a].getAttribute("data-placeholder")||this.elements[a].setAttribute("data-placeholder",this.options.placeholder),this.elements[a].setAttribute("data-medium-element",!0),this.bindParagraphCreation(a).bindReturn(a).bindTab(a).bindAnchorPreview(a),this.options.disableToolbar||this.elements[a].getAttribute("data-disable-toolbar")||(b=!0);return b&&this.initToolbar().bindButtons().bindAnchorForm(),this},serialize:function(){var a,b,c={};for(a=0;a<this.elements.length;a+=1)b=""!==this.elements[a].id?this.elements[a].id:"element-"+a,c[b]={value:this.elements[a].innerHTML.trim()};return c},bindParagraphCreation:function(a){var c=this;return this.elements[a].addEventListener("keyup",function(a){var d,e=f();e&&e.getAttribute("data-medium-element")&&0===e.children.length&&!c.options.disableReturn&&!e.getAttribute("data-disable-return")&&b.execCommand("formatBlock",!1,"p"),13!==a.which||a.shiftKey||(e=f(),d=e.tagName.toLowerCase(),c.options.disableReturn||this.getAttribute("data-disable-return")||"li"===d||c.isListItemChild(e)||(b.execCommand("formatBlock",!1,"p"),"a"===d&&b.execCommand("unlink",!1,null)))}),this},isListItemChild:function(a){for(var b=a.parentNode,c=b.tagName.toLowerCase();-1===this.parentElements.indexOf(c)&&"div"!==c;){if("li"===c)return!0;if(b=b.parentNode,!b||!b.tagName)return!1;c=b.tagName.toLowerCase()}return!1},bindReturn:function(a){var b=this;return this.elements[a].addEventListener("keypress",function(a){13===a.which&&(b.options.disableReturn||this.getAttribute("data-disable-return"))&&a.preventDefault()}),this},bindTab:function(a){return this.elements[a].addEventListener("keydown",function(a){if(9===a.which){var c=f().tagName.toLowerCase();"pre"===c&&(a.preventDefault(),b.execCommand("insertHtml",null,"    "))}}),this},buttonTemplate:function(a){var b=this.getButtonLabels(this.options.buttonLabels),c={bold:'<li><button class="medium-editor-action medium-editor-action-bold" data-action="bold" data-element="b">'+b.bold+"</button></li>",italic:'<li><button class="medium-editor-action medium-editor-action-italic" data-action="italic" data-element="i">'+b.italic+"</button></li>",underline:'<li><button class="medium-editor-action medium-editor-action-underline" data-action="underline" data-element="u">'+b.underline+"</button></li>",strikethrough:'<li><button class="medium-editor-action medium-editor-action-strikethrough" data-action="strikethrough" data-element="strike"><strike>A</strike></button></li>',superscript:'<li><button class="medium-editor-action medium-editor-action-superscript" data-action="superscript" data-element="sup">'+b.superscript+"</button></li>",subscript:'<li><button class="medium-editor-action medium-editor-action-subscript" data-action="subscript" data-element="sub">'+b.subscript+"</button></li>",anchor:'<li><button class="medium-editor-action medium-editor-action-anchor" data-action="anchor" data-element="a">'+b.anchor+"</button></li>",image:'<li><button class="medium-editor-action medium-editor-action-image" data-action="image" data-element="img">'+b.image+"</button></li>",header1:'<li><button class="medium-editor-action medium-editor-action-header1" data-action="append-'+this.options.firstHeader+'" data-element="'+this.options.firstHeader+'">'+b.header1+"</button></li>",header2:'<li><button class="medium-editor-action medium-editor-action-header2" data-action="append-'+this.options.secondHeader+'" data-element="'+this.options.secondHeader+'">'+b.header2+"</button></li>",quote:'<li><button class="medium-editor-action medium-editor-action-quote" data-action="append-blockquote" data-element="blockquote">'+b.quote+"</button></li>",orderedlist:'<li><button class="medium-editor-action medium-editor-action-orderedlist" data-action="insertorderedlist" data-element="ol">'+b.orderedlist+"</button></li>",unorderedlist:'<li><button class="medium-editor-action medium-editor-action-unorderedlist" data-action="insertunorderedlist" data-element="ul">'+b.unorderedlist+"</button></li>",pre:'<li><button class="medium-editor-action medium-editor-action-pre" data-action="append-pre" data-element="pre">'+b.pre+"</button></li>"};return c[a]||!1},getButtonLabels:function(a){var b,c,d={bold:"<b>B</b>",italic:"<b><i>I</i></b>",underline:"<b><u>U</u></b>",superscript:"<b>x<sup>1</sup></b>",subscript:"<b>x<sub>1</sup></b>",anchor:"<b>#</b>",image:"<b>image</b>",header1:"<b>H1</b>",header2:"<b>H2</b>",quote:"<b>&ldquo;</b>",orderedlist:"<b>1.</b>",unorderedlist:"<b>&bull;</b>",pre:"<b>0101</b>"};if("fontawesome"===a?b={bold:'<i class="fa fa-bold"></i>',italic:'<i class="fa fa-italic"></i>',underline:'<i class="fa fa-underline"></i>',superscript:'<i class="fa fa-superscript"></i>',subscript:'<i class="fa fa-subscript"></i>',anchor:'<i class="fa fa-link"></i>',image:'<i class="fa fa-picture-o"></i>',quote:'<i class="fa fa-quote-right"></i>',orderedlist:'<i class="fa fa-list-ol"></i>',unorderedlist:'<i class="fa fa-list-ul"></i>',pre:'<i class="fa fa-code fa-lg"></i>'}:"object"==typeof a&&(b=a),"object"==typeof b)for(c in b)b.hasOwnProperty(c)&&(d[c]=b[c]);return d},toolbarTemplate:function(){var a,b,c=this.options.buttons,d='<ul id="medium-editor-toolbar-actions" class="medium-editor-toolbar-actions clearfix">';for(a=0;a<c.length;a+=1)b=this.buttonTemplate(c[a]),b&&(d+=b);return d+='</ul><div class="medium-editor-toolbar-form-anchor" id="medium-editor-toolbar-form-anchor">    <input type="text" value="" placeholder="'+this.options.anchorInputPlaceholder+'">    <a href="#">&times;</a></div>'},initToolbar:function(){return this.toolbar?this:(this.toolbar=this.createToolbar(),this.keepToolbarAlive=!1,this.anchorForm=this.toolbar.querySelector(".medium-editor-toolbar-form-anchor"),this.anchorInput=this.anchorForm.querySelector("input"),this.toolbarActions=this.toolbar.querySelector(".medium-editor-toolbar-actions"),this.anchorPreview=this.createAnchorPreview(),this)},createToolbar:function(){var a=b.createElement("div");return a.id="medium-editor-toolbar-"+this.id,a.className="medium-editor-toolbar",a.innerHTML=this.toolbarTemplate(),b.getElementsByTagName("body")[0].appendChild(a),a},bindSelect:function(){var a,c=this,d="";for(this.checkSelectionWrapper=function(a){return a&&c.clickingIntoArchorForm(a)?!1:(clearTimeout(d),d=setTimeout(function(){c.checkSelection()},c.options.delay),void 0)},b.documentElement.addEventListener("mouseup",this.checkSelectionWrapper),a=0;a<this.elements.length;a+=1)this.elements[a].addEventListener("keyup",this.checkSelectionWrapper),this.elements[a].addEventListener("blur",this.checkSelectionWrapper);return this},checkSelection:function(){var b,c;return this.keepToolbarAlive===!0||this.options.disableToolbar||(b=a.getSelection(),""===b.toString().trim()||this.options.allowMultiParagraphSelection===!1&&this.hasMultiParagraphs()?this.hideToolbarActions():(c=this.getSelectionElement(),!c||c.getAttribute("data-disable-toolbar")?this.hideToolbarActions():this.checkSelectionElement(b,c))),this},clickingIntoArchorForm:function(a){var b=this;return a.type&&"blur"===a.type.toLowerCase()&&a.relatedTarget&&a.relatedTarget===b.anchorInput?!0:!1},hasMultiParagraphs:function(){var a=g().replace(/<[\S]+><\/[\S]+>/gim,""),b=a.match(/<(p|h[0-6]|blockquote)>([\s\S]*?)<\/(p|h[0-6]|blockquote)>/g);return b?b.length:0},checkSelectionElement:function(a,b){var c;for(this.selection=a,this.selectionRange=this.selection.getRangeAt(0),c=0;c<this.elements.length;c+=1)if(this.elements[c]===b)return this.setToolbarButtonStates().setToolbarPosition().showToolbarActions(),void 0;this.hideToolbarActions()},getSelectionElement:function(){var b,c=a.getSelection(),d=c.getRangeAt(0),e=d.commonAncestorContainer,f=e.parentNode,g=function(a){var b=a;try{for(;!b.getAttribute("data-medium-element");)b=b.parentNode}catch(c){return!1}return b};try{b=e.getAttribute("data-medium-element")?e:g(f)}catch(h){b=g(f)}return b},setToolbarPosition:function(){var b=50,c=a.getSelection(),d=c.getRangeAt(0),e=d.getBoundingClientRect(),f=this.options.diffLeft-this.toolbar.offsetWidth/2,g=(e.left+e.right)/2,h=this.toolbar.offsetWidth/2;return e.top<b?(this.toolbar.classList.add("medium-toolbar-arrow-over"),this.toolbar.classList.remove("medium-toolbar-arrow-under"),this.toolbar.style.top=b+e.bottom-this.options.diffTop+a.pageYOffset-this.toolbar.offsetHeight+"px"):(this.toolbar.classList.add("medium-toolbar-arrow-under"),this.toolbar.classList.remove("medium-toolbar-arrow-over"),this.toolbar.style.top=e.top+this.options.diffTop+a.pageYOffset-this.toolbar.offsetHeight+"px"),this.toolbar.style.left=h>g?f+h+"px":a.innerWidth-g<h?a.innerWidth+f-h+"px":f+g+"px",this.hideAnchorPreview(),this},setToolbarButtonStates:function(){var a,b=this.toolbarActions.querySelectorAll("button");for(a=0;a<b.length;a+=1)b[a].classList.remove("medium-editor-button-active");return this.checkActiveButtons(),this},checkActiveButtons:function(){var a=this.selection.anchorNode;for(a.tagName||(a=this.selection.anchorNode.parentNode);void 0!==a.tagName&&-1===this.parentElements.indexOf(a.tagName.toLowerCase);)this.activateButton(a.tagName.toLowerCase()),a=a.parentNode},activateButton:function(a){var b=this.toolbar.querySelector('[data-element="'+a+'"]');null!==b&&-1===b.className.indexOf("medium-editor-button-active")&&(b.className+=" medium-editor-button-active")},bindButtons:function(){var a,b=this.toolbar.querySelectorAll("button"),c=this,d=function(a){a.preventDefault(),a.stopPropagation(),void 0===c.selection&&c.checkSelection(),this.className.indexOf("medium-editor-button-active")>-1?this.classList.remove("medium-editor-button-active"):this.className+=" medium-editor-button-active",c.execAction(this.getAttribute("data-action"),a)};for(a=0;a<b.length;a+=1)b[a].addEventListener("click",d);return this.setFirstAndLastItems(b),this},setFirstAndLastItems:function(a){return a[0].className+=" medium-editor-button-first",a[a.length-1].className+=" medium-editor-button-last",this},execAction:function(c,d){c.indexOf("append-")>-1?(this.execFormatBlock(c.replace("append-","")),this.setToolbarPosition(),this.setToolbarButtonStates()):"anchor"===c?this.triggerAnchorAction(d):"image"===c?b.execCommand("insertImage",!1,a.getSelection()):(b.execCommand(c,!1,null),this.setToolbarPosition())},triggerAnchorAction:function(){return"a"===this.selection.anchorNode.parentNode.tagName.toLowerCase()?b.execCommand("unlink",!1,null):"block"===this.anchorForm.style.display?this.showToolbarActions():this.showAnchorForm(),this},execFormatBlock:function(a){var c=this.getSelectionData(this.selection.anchorNode);if("blockquote"===a&&c.el&&"blockquote"===c.el.parentNode.tagName.toLowerCase())return b.execCommand("outdent",!1,null);if(c.tagName===a&&(a="p"),this.isIE){if("blockquote"===a)return b.execCommand("indent",!1,a);a="<"+a+">"}return b.execCommand("formatBlock",!1,a)},getSelectionData:function(a){var b;for(a&&a.tagName&&(b=a.tagName.toLowerCase());a&&-1===this.parentElements.indexOf(b);)a=a.parentNode,a&&a.tagName&&(b=a.tagName.toLowerCase());return{el:a,tagName:b}},getFirstChild:function(a){for(var b=a.firstChild;null!==b&&1!==b.nodeType;)b=b.nextSibling;return b},hideToolbarActions:function(){this.keepToolbarAlive=!1,this.toolbar.classList.remove("medium-editor-toolbar-active")},showToolbarActions:function(){var a,b=this;this.anchorForm.style.display="none",this.toolbarActions.style.display="block",this.keepToolbarAlive=!1,clearTimeout(a),a=setTimeout(function(){b.toolbar.classList.contains("medium-editor-toolbar-active")||b.toolbar.classList.add("medium-editor-toolbar-active")},100)},showAnchorForm:function(a){this.toolbarActions.style.display="none",this.savedSelection=d(),this.anchorForm.style.display="block",this.keepToolbarAlive=!0,this.anchorInput.focus(),this.anchorInput.value=a||""},bindAnchorForm:function(){var a=this.anchorForm.querySelector("a"),b=this;return this.anchorForm.addEventListener("click",function(a){a.stopPropagation()}),this.anchorInput.addEventListener("keyup",function(a){13===a.keyCode&&(a.preventDefault(),b.createLink(this))}),this.anchorInput.addEventListener("click",function(a){a.stopPropagation(),b.keepToolbarAlive=!0}),this.anchorInput.addEventListener("blur",function(){b.keepToolbarAlive=!1,b.checkSelection()}),a.addEventListener("click",function(a){a.preventDefault(),b.showToolbarActions(),e(b.savedSelection)}),this},hideAnchorPreview:function(){this.anchorPreview.classList.remove("medium-editor-anchor-preview-active")},showAnchorPreview:function(b){if(this.anchorPreview.classList.contains("medium-editor-anchor-preview-active"))return!0;var c,d,e,f=this,g=40,h=b.getBoundingClientRect(),i=(h.left+h.right)/2;return f.anchorPreview.querySelector("i").innerHTML=b.href,c=f.anchorPreview.offsetWidth/2,d=f.options.diffLeft-c,clearTimeout(e),e=setTimeout(function(){f.anchorPreview.classList.contains("medium-editor-anchor-preview-active")||f.anchorPreview.classList.add("medium-editor-anchor-preview-active")},100),f.observeAnchorPreview(b),f.anchorPreview.classList.add("medium-toolbar-arrow-over"),f.anchorPreview.classList.remove("medium-toolbar-arrow-under"),f.anchorPreview.style.top=Math.round(g+h.bottom-f.options.diffTop+a.pageYOffset-f.anchorPreview.offsetHeight)+"px",f.anchorPreview.style.left=c>i?d+c+"px":a.innerWidth-i<c?a.innerWidth+d-c+"px":d+i+"px",this},observeAnchorPreview:function(a){var b=this,c=(new Date).getTime(),d=!0,e=function(){c=(new Date).getTime(),d=!0},f=function(a){a.relatedTarget&&/anchor-preview/.test(a.relatedTarget.className)||(d=!1)},g=setInterval(function(){if(d)return!0;var h=(new Date).getTime()-c;h>b.options.anchorPreviewHideDelay&&(b.hideAnchorPreview(),clearInterval(g),b.anchorPreview.removeEventListener("mouseover",e),b.anchorPreview.removeEventListener("mouseout",f),a.removeEventListener("mouseover",e),a.removeEventListener("mouseout",f))},200);b.anchorPreview.addEventListener("mouseover",e),b.anchorPreview.addEventListener("mouseout",f),a.addEventListener("mouseover",e),a.addEventListener("mouseout",f)},createAnchorPreview:function(){var a=this,c=b.createElement("div");return c.id="medium-editor-anchor-preview-"+this.id,c.className="medium-editor-anchor-preview",c.innerHTML=this.anchorPreviewTemplate(),b.getElementsByTagName("body")[0].appendChild(c),c.addEventListener("click",function(){a.anchorPreviewClickHandler()}),c},anchorPreviewTemplate:function(){return'<div class="medium-editor-toolbar-anchor-preview" id="medium-editor-toolbar-anchor-preview">    <i class="medium-editor-toolbar-anchor-preview-inner">http://google.com/</i></div>'},anchorPreviewClickHandler:function(){if(this.activeAnchor){var c=this,d=b.createRange(),e=a.getSelection();d.selectNodeContents(c.activeAnchor),e.removeAllRanges(),e.addRange(d),setTimeout(function(){c.showAnchorForm(c.activeAnchor.href),c.keepToolbarAlive=!1},100+c.options.delay)}this.hideAnchorPreview()},editorAnchorObserver:function(a){var b=this,c=!0,d=function(){c=!1,b.activeAnchor.removeEventListener("mouseout",d)};if(a.target&&"a"===a.target.tagName.toLowerCase()){if(this.toolbar.classList.contains("medium-editor-toolbar-active"))return!0;this.activeAnchor=a.target,this.activeAnchor.addEventListener("mouseout",d),setTimeout(function(){c&&b.showAnchorPreview(a.target)},b.options.delay)}},bindAnchorPreview:function(a){var b=this;return this.elements[a].addEventListener("mouseover",function(a){b.editorAnchorObserver(a)}),this},setTargetBlank:function(){var a,b=f();if("a"===b.tagName.toLowerCase())b.target="_blank";else for(b=b.getElementsByTagName("a"),a=0;a<b.length;a+=1)b[a].target="_blank"},createLink:function(a){e(this.savedSelection),b.execCommand("createLink",!1,a.value),this.options.targetBlank&&this.setTargetBlank(),this.showToolbarActions(),a.value=""},bindWindowActions:function(){var b,c=this;return this.windowResizeHandler=function(){clearTimeout(b),b=setTimeout(function(){c.toolbar&&c.toolbar.classList.contains("medium-editor-toolbar-active")&&c.setToolbarPosition()},100)},a.addEventListener("resize",this.windowResizeHandler),this},activate:function(){var a;if(!this.isActive){for(void 0!==this.toolbar&&(this.toolbar.style.display="block"),this.isActive=!0,a=0;a<this.elements.length;a+=1)this.elements[a].setAttribute("contentEditable",!0);this.bindWindowActions().bindSelect()}},deactivate:function(){var c;if(this.isActive)for(this.isActive=!1,void 0!==this.toolbar&&(this.toolbar.style.display="none"),b.documentElement.removeEventListener("mouseup",this.checkSelectionWrapper),a.removeEventListener("resize",this.windowResizeHandler),c=0;c<this.elements.length;c+=1)this.elements[c].removeEventListener("keyup",this.checkSelectionWrapper),this.elements[c].removeEventListener("blur",this.checkSelectionWrapper),this.elements[c].removeEventListener("paste",this.pasteWrapper),this.elements[c].removeAttribute("contentEditable")},bindPaste:function(){var a,c=this;for(this.pasteWrapper=function(a){var d,e,f="";if(this.classList.remove("medium-editor-placeholder"),!c.options.forcePlainText)return this;if(a.clipboardData&&a.clipboardData.getData&&!a.defaultPrevented)if(a.preventDefault(),c.options.disableReturn)b.execCommand("insertHTML",!1,a.clipboardData.getData("text/plain"));else{for(d=a.clipboardData.getData("text/plain").split(/[\r\n]/g),e=0;e<d.length;e+=1)""!==d[e]&&(f+="<p>"+d[e]+"</p>");b.execCommand("insertHTML",!1,f)}},a=0;a<this.elements.length;a+=1)this.elements[a].addEventListener("paste",this.pasteWrapper);return this},setPlaceholders:function(){var a,b=function(a){""===a.textContent.replace(/^\s+|\s+$/g,"")&&a.classList.add("medium-editor-placeholder")},c=function(a){this.classList.remove("medium-editor-placeholder"),"keypress"!==a.type&&b(this)};for(a=0;a<this.elements.length;a+=1)b(this.elements[a]),this.elements[a].addEventListener("blur",c),this.elements[a].addEventListener("keypress",c);return this}}}(window,document);