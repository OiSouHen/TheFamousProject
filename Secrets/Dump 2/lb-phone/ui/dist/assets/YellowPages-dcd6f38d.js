import{u as g,r as n,p as h,$ as M,j as l,a as t,L as s,ah as $,w as q,m as v,a8 as z,ab as B,h as K,D as O,A as H,k as X,bq as J,O as Q,d as C,as as Z,C as E,b as I,az as ee,f as te,i as ae,N as se,P as b}from"./index-2acb14b9.js";import{formatDate as ie}from"./Marketplace-a2789202.js";const R={posts:[{id:"1",title:"Looking for a new job",description:"I am looking for a new job in the field of software development. I have 5 years of experience in the field and I am looking for a new challenge. I am open to any offers and I am willing to relocate.",number:"0601232354"},{id:"2",title:"Banshee",description:"Selling my 2020 model Bravado Banshee, low mileage and in perfect condition. Price is negotiable.",number:"0606643134",attachment:"https://www.gtabase.com/images/gta-5/vehicles/sports/main/banshee.jpg",price:74999},{id:"3",title:"2018+ Sanchez",description:"Looking for a 2018 or newer model Sanchez. I am willing to pay up to 20k for a good condition bike.",number:"0651566734"}]};function re(){const T=g(b.Settings),L=g(b.PhoneNumber),p=g(I),[w,y]=n.useState(!1),[P,u]=n.useState([]),[a,c]=n.useState(null),[Y,k]=n.useState(0),[G,S]=n.useState(!1),[W,f]=n.useState(!1),[m,x]=n.useState(""),[A,D]=n.useState(""),[U,_]=n.useState([]);n.useEffect(()=>{const e=setTimeout(()=>x(A),500);return()=>clearTimeout(e)},[A]),n.useEffect(()=>{h("YellowPages",{action:"getPosts",page:0},R.posts).then(e=>{e&&e.length>0?(u(e),e.length<10&&S(!0)):S(!0)}),h("isAdmin",null,!1).then(e=>y(e))},[]),n.useEffect(()=>{m.length>0&&h("YellowPages",{action:"search",query:m},R.posts.filter(e=>e.title.toLowerCase().includes(m.toLowerCase())||e.description.toLowerCase().includes(m.toLowerCase()))).then(e=>{e&&_(e)})},[m]);const N=()=>{if(!(a!=null&&a.title)||!(a!=null&&a.description)){let i;switch(!0){case!(a!=null&&a.title):i=s("APPS.YELLOWPAGES.ERROR_POPUP.NO_TITLE");break;case!(a!=null&&a.description):i=s("APPS.YELLOWPAGES.ERROR_POPUP.NO_DESCRIPTION");break;default:i="UNKNOWN ERROR";break}E.PopUp.set({title:s("APPS.YELLOWPAGES.ERROR_POPUP.TITLE"),description:i,buttons:[{title:s("APPS.YELLOWPAGES.ERROR_POPUP.OK")}]});return}let e={...a,number:L};h("YellowPages",{action:"sendPost",data:e},!0).then(i=>{i&&(u([{...e,id:i},...P]),c(null))})},V=e=>{e&&E.PopUp.set({title:s("APPS.YELLOWPAGES.DELETE_POPUP.TITLE"),description:s("APPS.YELLOWPAGES.DELETE_POPUP.TEXT"),buttons:[{title:s("APPS.YELLOWPAGES.DELETE_POPUP.CANCEL")},{title:s("APPS.YELLOWPAGES.DELETE_POPUP.PROCEED"),color:"red",cb:()=>{h("YellowPages",{action:"deletePost",id:e},!0).then(i=>{i&&u(P.filter(d=>d.id!==e))})}}]})},j=e=>{e&&E.PopUp.set({title:s("APPS.SERVICES.CALL_POPUP.TITLE"),description:s("APPS.SERVICES.CALL_POPUP.DESCRIPTION").format({name:te(e)}),buttons:[{title:s("APPS.SERVICES.CALL_POPUP.CANCEL")},{title:s("APPS.SERVICES.CALL_POPUP.PROCEED"),cb:()=>{let i=O(e);ae({...i,number:e})}}]})},F=e=>{if(G||W)return;let i=document.querySelector("#last");if(!i)return;!se(i)&&(f(!0),h("YellowPages",{action:"getPosts",page:Y+1},null).then(r=>{r&&r.length>0?(u([...P,...r]),f(!1)):S(!0)}),k(r=>r+1))};return M("yellowPages:newPost",e=>{T.airplaneMode||u([e,...P])}),l("div",{className:"pages-container",children:[l("div",{className:"pages-header",children:[l("div",{className:"pages-header-top",children:[t("div",{className:"title",children:s("APPS.YELLOWPAGES.PAGES")}),t($,{onClick:()=>c({})})]}),t(q,{placeholder:s("APPS.YELLOWPAGES.SEARCH"),onChange:e=>D(e.target.value)})]}),t("div",{className:"pages-wrapper",children:t("div",{className:"posts",onScroll:F,children:(m.length>0?U:P).map((e,i)=>{var r;let d=i===P.length-1?"last":"";return t(v.div,{className:"post-item",id:d,initial:{opacity:0,scale:.9},whileInView:{opacity:1,scale:1},exit:{opacity:0,scale:.9},viewport:{once:!0},transition:{duration:.2,ease:"easeInOut"},children:l("div",{className:"post-info",children:[l("div",{className:"post-header",children:[t("div",{className:"title",children:e.title}),t("div",{className:"date",children:ie(e.timestamp)})]}),l("div",{className:"post-content",children:[l("div",{className:"post-text",style:{maxWidth:e.attachment?"65%":"100%"},children:[t("div",{className:"description",children:z(e.description)}),e.price&&t("div",{className:"price",children:p==null?void 0:p.CurrencyFormat.replace("%s",(r=e.price)==null?void 0:r.toLocaleString())})]}),e.attachment&&t("div",{className:"attachment",children:t(B,{src:e.attachment})})]}),l("div",{className:"post-footer",children:[t(K,{className:"green",onClick:()=>{let o=O(e.number);H.patch({active:{name:"Messages",data:{number:e.number,name:o==null?void 0:o.name,avatar:o==null?void 0:o.avatar,view:"messages"}}})}}),t(X,{className:"blue",onClick:()=>j(e.number)}),(L===e.number||w)&&t(J,{className:"red",onClick:o=>{o.stopPropagation(),V(e.id)}})]})]})},i)})})}),t(Q,{children:a&&l(v.div,{initial:{opacity:0,y:100},animate:{opacity:1,y:0},exit:{opacity:0,y:100},transition:{duration:.2,ease:"easeInOut"},className:"new-post-container",children:[l("div",{className:"new-post-header",children:[t("div",{}),t("div",{className:"close",children:t("div",{onClick:()=>c(null)})}),t("div",{className:"post",onClick:N,children:s("APPS.MARKETPLACE.POST")})]}),l("div",{className:"new-post-body",children:[l("div",{className:"item",children:[t("div",{className:"title",children:s("APPS.YELLOWPAGES.TITLE")}),t(C,{type:"text",placeholder:s("APPS.YELLOWPAGES.TITLE"),maxLength:50,onChange:e=>c({...a,title:e.target.value})})]}),l("div",{className:"item",children:[t("div",{className:"title",children:s("APPS.YELLOWPAGES.DESCRIPTION")}),t(Z,{type:"text",placeholder:s("APPS.YELLOWPAGES.DESCRIPTION"),maxLength:250,rows:5,onChange:e=>c({...a,description:e.target.value})})]}),t("div",{className:"item",children:t("div",{className:"images",children:t("div",{className:"image",style:{backgroundImage:`url(${a==null?void 0:a.attachment})`},onClick:()=>{var e,i,d;if(a!=null&&a.attachment)return c({...a,attachment:null});E.Gallery.set({allowExternal:(d=(i=(e=I)==null?void 0:e.value)==null?void 0:i.AllowExternal)==null?void 0:d.YellowPages,onSelect:r=>c({...a,attachment:r.src})})},children:!(a!=null&&a.attachment)&&t(ee,{})})})}),l("div",{className:"item",children:[t("div",{className:"title",children:s("APPS.YELLOWPAGES.PRICE")}),t(C,{type:"number",placeholder:"0",onChange:e=>{if(!e.target.value.match(/^[0-9]*$/))return e.preventDefault();c({...a,price:!isNaN(parseFloat(e.target.value))&&parseFloat(e.target.value)})}})]}),t("div",{className:"button",onClick:()=>N(),children:s("APPS.YELLOWPAGES.POST")})]})]})})]})}export{re as default};
