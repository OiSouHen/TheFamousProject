import{r as S,j as n,a as r}from"./jsx-runtime-21230753.js";import{o as c,d as l,f as h,L as i,p as C,t as T,I as g,T as L,C as v}from"./Phone-aa8facc7.js";import{z as w,ae as I,ay as D}from"./index.esm-01be3299.js";import"./number-28525126.js";function F(){const[m,P]=S.useState(""),[a,u]=S.useState([]),[o,d]=S.useState(null);S.useEffect(()=>{if(c.APPS.NOTES.notes.value&&c.APPS.NOTES.notes.value.length>0){l("info","Using cached notes, not fetching",c.APPS.NOTES.notes.value),u(c.APPS.NOTES.notes.value);return}l("info","Fetching notes"),h("Notes",{action:"fetch"}).then(e=>{if(!e)return l("warning","Failed to fetch notes, server returned false");l("info","Fetched notes",e),u(e),c.APPS.NOTES.notes.set(e)})},[]);const p=e=>{let s=Math.floor(Date.now()),t={title:i("APPS.NOTES.NEW_NOTE"),content:"",timestamp:s,id:null};h("Notes",{action:"create",data:t}).then(N=>{t.id=N,d(t),u([...a,t]),c.APPS.NOTES.notes.set({...a,tempData:t})})},O=e=>{let s=Math.floor(Date.now()),t=[...a],N=t.findIndex(E=>E.id===e.id),f=t[N];if(f.title===e.title&&f.content===e.content){l("info","Note is the same, not saving"),d(null);return}t[N]={...e,timestamp:s},h("Notes",{action:"save",data:t[N]}).then(E=>{if(!E)return l("warning","Failed to save note, server returned false");l("info","Saved note"),d(null),u(t),c.APPS.NOTES.notes.set(t)})},A=e=>{h("Notes",{action:"remove",id:e}).then(s=>{if(!s)return l("warning","Failed to remove note, server returned false");let t=a==null?void 0:a.filter(N=>N.id!==e);d(null),u(t),c.APPS.NOTES.notes.set(t),l("info","Removed note")})};return n("div",{className:"notes-container slide-right",children:o?r("div",{className:"notes-wrapper slide-left",children:[r("div",{className:"top",children:[r("div",{className:"back",onClick:()=>O(o),children:[n("i",{className:"fal fa-chevron-left"}),i("APPS.NOTES.TITLE")]}),n(g,{className:"title",defaultValue:o.title,onChange:e=>{d({...o,title:e.target.value})}}),n("div",{})]}),n(L,{onChange:e=>{d({...o,content:e.target.value})},defaultValue:o.content}),r("div",{className:"notes-bottom",children:[n(I,{onClick:()=>v.PopUp.set({title:i("APPS.NOTES.DELETE_TITLE").format({title:o.title}),description:i("APPS.NOTES.DELETE_TEXT").format({title:o.title}),buttons:[{title:i("APPS.NOTES.BUTTON_CANCEL")},{title:i("APPS.NOTES.BUTTON_DELETE"),color:"red",cb:()=>{A(o.id)}}]})}),n("div",{className:"amount",children:i("APPS.NOTES.LAST_EDITED").format({date:T(o.timestamp)})}),n(D,{onClick:()=>v.Share.set({type:"note",data:o})})]})]}):r("div",{className:"notes-wrapper slide-right",children:[n("div",{className:"title",children:i("APPS.NOTES.TITLE")}),n(C,{placeholder:i("APPS.NOTES.SEARCH_PLACEHOLDER"),onChange:e=>P(e.target.value)}),n("div",{className:"notes-body",children:n("div",{className:"notes-list",children:a==null?void 0:a.filter(e=>{var s,t;return((s=e.title)==null?void 0:s.toLowerCase().includes(m==null?void 0:m.toLowerCase()))||((t=e.content)==null?void 0:t.toLowerCase().includes(m==null?void 0:m.toLowerCase()))}).sort((e,s)=>s.timestamp-e.timestamp).map((e,s)=>r("div",{className:"note-item",onClick:()=>{d(e)},children:[n("div",{className:"note-title",children:e.title}),r("div",{className:"note-details",children:[n("div",{className:"date",children:T(e.timestamp)}),n("div",{className:"content",children:e.content.length>30?e.content.slice(0,30)+"...":e.content})]})]},s))})}),r("div",{className:"notes-bottom",children:[n("div",{}),n("div",{className:"amount",children:i("APPS.NOTES.FOOTER").format({amount:(a==null?void 0:a.length)??0})}),n(w,{onClick:p})]})]})})}export{F as default};
