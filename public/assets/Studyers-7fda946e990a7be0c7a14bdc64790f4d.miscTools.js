/*
	Create a unique id according to timestamp.
*/
function uniqueId(){return"id_"+(new Date).getTime()}function modifyCanvasAndImageWidth(){var a=$("#text-editor").width(),b=document.getElementsByTagName("canvas");for(i=0;i<b.length;i++)b[i].width=a;var c=$("#text-editor img");for(i=0;i<c.length;i++)c[i].width=a}function buttonsAppend(a){return'<div class="dont-save text-after btn" after="'+a+'">+ textarea</div><div class="dont-save draw-after btn" after="'+a+'">+ drawpad</div><div class="dont-save graph-after btn" after="'+a+'">+ graph</div>'}