import{u as D,r as d,j as c,m as B,a as e,F as te,L as i,q as T,C as y,Z as _e,_ as be,b as X,d as ce,f as Y,p as U,P as z,$ as re,a0 as Ce,S as we,O as le,I as $e,g as ne,a1 as Ve,i as fe,a2 as xe,a3 as Te,a4 as ve,a5 as Ie,a6 as Fe,H as me,a7 as Pe,s as W,t as Ae,N as Ye,a8 as Me,a9 as He,A as ue,aa as Ne,ab as Oe,ac as pe,Q as je,R as We,ad as Se,o as qe,ae as Xe,e as Z,af as ze,y as Be,z as Qe,ag as Ke,ah as Je,w as Ze,ai as et,aj as tt,ak as at,x as st}from"./index-2acb14b9.js";import{A as nt,g as it}from"./audioRecorder-b9544cbe.js";const Ge=t=>{if(t)return/<!SENT-LOCATION-X=(-?\d*\.?\d*)Y=(-?\d*\.?\d*)!>/.test(t)},ye=t=>{if(t)return t==="<!CALL-NO-ANSWER!>"},rt=t=>{if(t)return/<!AUDIO-MESSAGE-IMAGE="(.*)"-AUDIO="(.*)"-DURATION="(.*)"!>/.test(t)},lt=t=>{if(t.length===0)return!0;if(t)return!/^<!.*!>$/.test(t)},ct=({onEnd:t,close:o})=>{const v=D(X),[g,p]=d.useState(!1),[P,a]=d.useState(0),[u,C]=d.useState(null),m=d.useRef(null);if(!v.EnableVoiceMessages)return null;d.useEffect(()=>{if(!g)return;let r=setInterval(()=>{a(h=>h+1)},1e3);return()=>clearInterval(r)},[g]),d.useEffect(()=>(m.current=new nt,()=>{m.current&&m.current.stop()}),[]);const I=r=>{let h=Math.floor(r/60),N=r%60;return`${h}:${N<10?"0":""}${N}`},s=async r=>{const h=await it(new Blob(r),25,7,324,55,3);C(h)};return c(B.div,{initial:{opacity:0,y:20},animate:{opacity:1,y:0},exit:{opacity:0,y:0},transition:{duration:.2,ease:"easeInOut"},className:"audioMessage-container",children:[e("div",{className:"close",onClick:o}),c("div",{className:"audioMessage-wrapper",children:[c("div",{className:"duration",children:[g&&e("div",{className:"dot"}),I(P)]}),e("div",{className:"content",children:g?e(te,{children:u!=null&&u.base64?e("img",{src:u==null?void 0:u.base64}):i("APPS.MESSAGES.LOADING")}):i("APPS.MESSAGES.START_RECORDING")}),e("div",{className:"button","data-recording":g,onClick:()=>{var h;if(!((h=navigator.mediaDevices)!=null&&h.getUserMedia)||!(m!=null&&m.current))return T("error","No media devices found!");let r=m.current;g?r.stop().then(N=>{if(!N){a(0),p(l=>!l),y.PopUp.set({title:i("APPS.MESSAGES.EMPTY_RECORDING.TITLE"),description:i("APPS.MESSAGES.EMPTY_RECORDING.DESCRIPTION"),buttons:[{title:i("APPS.MESSAGES.EMPTY_RECORDING.OK")}]});return}t(N),p(l=>!l)}):(r.start(100,s),p(N=>!N))},children:g?e(_e,{}):e(be,{})})]})]})},ot=({paymentAmount:t,setPaymentAmount:o,close:v})=>{const{User:g}=d.useContext(ae),p=D(X),[P]=g,[a,u]=d.useState(0),[C,m]=d.useState(4);let I={0:3,11:2.75,14:2.2};return d.useEffect(()=>{a===0&&m(I[0]);let s=0;for(let r=0;r<Object.keys(I).length;r++)a>=parseInt(Object.keys(I)[r])&&(s=I[Object.keys(I)[r]]);m(s)},[a]),d.useEffect(()=>{o(a)},[a]),c(B.div,{initial:{opacity:0,y:20},animate:{opacity:1,y:0},exit:{opacity:0,y:0},transition:{duration:.2,ease:"easeInOut"},className:"payment-container",children:[e("div",{className:"close",onClick:v}),c("div",{className:"payment-wrapper",children:[e("div",{className:"button",onClick:()=>t>0&&u(s=>s-1),children:"-"}),e("div",{className:"amount",children:e(ce,{type:"number",value:t,style:{fontSize:`${C}rem`},onChange:s=>{if(s.target.value.match(/^[0-9]+$/)&&parseFloat(s.target.value)>0&&parseFloat(s.target.value)<(p.MaxTransferAmount??Number.MAX_SAFE_INTEGER))u(parseFloat(s.target.value));else return s.preventDefault()}})}),e("div",{className:"button",onClick:()=>u(s=>s+1),children:"+"})]}),c("div",{className:"payment-buttons",children:[e("div",{className:"button",onClick:()=>dt(t,P.number),children:i("APPS.MESSAGES.PAY.REQUEST")}),e("div",{className:"button",onClick:()=>De(t,{id:P.id,name:P.name,number:P.number}),children:i("APPS.MESSAGES.PAY.SEND")})]})]})},De=(t,o)=>{var v;if(X.value.EnableMessagePay&&!(!t&&t<=0)){if(t>(((v=X.value)==null?void 0:v.MaxTransferAmount)??Number.MAX_SAFE_INTEGER))return T("error","Amount is too high");y.PopUp.set({title:i("APPS.MESSAGES.PAY.SEND_TITLE").format({amount:X.value.CurrencyFormat.replace("%s",t.toString())}),description:i("APPS.MESSAGES.PAY.SEND_DESCRIPTION").format({amount:X.value.CurrencyFormat.replace("%s",t.toString()),name:o.name??Y(o.number)}),buttons:[{title:i("APPS.MESSAGES.PAY.SEND_BUTTON_CANCEL")},{title:i("APPS.MESSAGES.PAY.SEND_BUTTON_SEND"),cb:()=>{U("Wallet",{action:"sendPayment",number:o.number,amount:t},{success:!0}).then(g=>{var p,P;if(g.success){let a={id:o.id,sender:(P=(p=z)==null?void 0:p.PhoneNumber)==null?void 0:P.value,content:`<!SENT-PAYMENT-${t}!>`,attachments:[],timestamp:Date.now()};w.set([...w.value,a])}else{T("error","Failed to send payment "+JSON.stringify(g)),setTimeout(()=>{y.PopUp.set({title:i(`APPS.WALLET.${g.reason}.TITLE`),description:i(`APPS.WALLET.${g.reason}.DESCRIPTION`),buttons:[{title:i("APPS.WALLET.OK")}]})},500);return}})}}]})}},dt=(t,o)=>{var g,p;if(!X.value.EnableMessagePay||!t&&t<=0)return;let v={sender:(p=(g=z)==null?void 0:g.PhoneNumber)==null?void 0:p.value,content:`<!REQUESTED-PAYMENT-${t}!>`,attachments:[],timestamp:Date.now()};U("Messages",{action:"sendMessage",number:o,content:v.content,attachments:[]},{messageId:Math.floor(Math.random()*1e3).toString()}).then(P=>{if(!P)return w.set([...w.value,{...v,delivered:!1}]);w.set([...w.value,{...v,id:P.messageId}])})},ke={Messagelist:[{id:"1",number:"4802940940",name:"Loaf Scripts",unread:!0,lastMessage:"Sure Thing!",messages:[{sender:"4802940940",content:"Sure Thing!",timestamp:Date.now()-1e3*60*60*2},{sender:"1234567890",content:"Ready to release more products?",timestamp:Date.now()-1e3*60*60*2-1e3*60*5},{sender:"4802940940",content:"Hey!",timestamp:Date.now()-1e3*60*60*2-1e3*60*10}],timestamp:Date.now()-1e3*60*60*2},{id:"2",name:"Office Chat",unread:!0,lastMessage:"is the meeting at 8pm?",timestamp:Date.now()-1e3*60*60*4,isGroup:!0,members:[{number:"4802940940",name:"Loaf Scripts",isOwner:!1},{number:"1566444151",name:"Peter",isOwner:!1},{number:"2051440412",name:"Peter",isOwner:!1},{number:"2051440412",isOwner:!1}],messages:[{sender:"4802940940",content:"is the meeting at 8pm?",timestamp:Date.now()-1e3*60*60*4},{sender:"1566444151",content:"please confirm the time",timestamp:Date.now()-1e3*60*60*4-1e3*60*5},{sender:"2051440412",content:"Hey everyone, please make sure to be on time for the meeting",timestamp:Date.now()-1e3*60*60*4-1e3*60*10}]},{id:"3",number:"4802940940",unread:!1,lastMessage:"yeah i dont know whats going on, it was super weird. i think i might have to go to the doctor",timestamp:Date.now()-1e3*60*60*2*24,messages:[{sender:"4802940940",content:"yeah i dont know whats going on, it was super weird. i think i might have to go to the doctor",timestamp:Date.now()-1e3*60*60*2*24},{sender:"1234567890",content:"i hope you feel better soon",timestamp:Date.now()-1e3*60*60*2*24-1e3*60*5},{sender:"4802940940",content:"still sick :(",timestamp:Date.now()-1e3*60*60*2*24-1e3*60*10}]},{id:"4",number:"4802940942",unread:!0,lastMessage:"see you!",timestamp:Date.now()-1e3*60*60*2*24*2,messages:[{sender:"4802940942",content:"see you!",timestamp:Date.now()-1e3*60*60*2*24*2},{sender:"1234567890",content:"ofcourse, i will be there",timestamp:Date.now()-1e3*60*60*2*24*2-1e3*60*3},{sender:"4802940942",content:"hey buddy, still on for tomorrow?",timestamp:Date.now()-1e3*60*60*2*24*2-1e3*60*3}]}]},w=me([]);function mt(){const{User:t,View:o,UnreadMessages:v}=d.useContext(ae),g=D(z.Settings),p=D(X),P=D(z.PhoneNumber),[a,u]=t,[C,m]=o,[I,s]=v,r=D(y.Emoji),h=D(y.Gif),[N,l]=d.useState(!1),[_,x]=d.useState(null),[H,G]=d.useState(!1),[L,q]=d.useState(!1),[V,Q]=d.useState(0),[K,E]=d.useState(0),[O,$]=d.useState(!1),[A,M]=d.useState(!1),b=D(w),[f,k]=d.useState(null),ie=d.useRef(null),he=d.useRef(0),[F,se]=d.useState({content:"",attachments:[]}),oe=d.useRef(!1);d.useEffect(()=>{var n;U("Messages",{action:"getMessages",page:0,id:a.id},((n=ke.Messagelist.find(S=>S.id===a.id))==null?void 0:n.messages)??[]).then(S=>{S&&S.length>0?w.set([...S.reverse()]):$(!0)})},[]);const Ee=()=>{if(F.content.length<=0&&F.attachments.length<=0&&!f)return T("info","Message is empty, returning");let n={sender:P,timestamp:Date.now(),id:a.id,content:F.content,attachments:F.attachments};if(!lt(F.content))return T("error","Message contains invalid characters, returning",F.content);if(f){if(oe.current)return;oe.current=!0,Pe("Image",f.waves.message).then(S=>{Pe("Audio",f.blob).then(R=>{n.content=`<!AUDIO-MESSAGE-IMAGE="${S}"-AUDIO="${R}"-DURATION="${f.duration}"!>`,U("Messages",{action:"sendMessage",number:a.number,content:n.content,id:a.id},{messageId:Math.random().toString(36).substring(7)}).then(j=>{j&&!g.airplaneMode?w.set([...w.value,{...n,id:j.messageId}]):w.set([...w.value,{...n,delivered:!1}]),oe.current=!1,k(null)})})});return}if(g.airplaneMode)return w.set([...w.value,{...n,delivered:!1}]);U("Messages",{action:"sendMessage",number:a.number,content:F.content,attachments:F.attachments,id:a.id},{messageId:Math.random().toString(36).substring(7)}).then(S=>{S?(w.set([...w.value,{...n,id:S.messageId}]),k(null)):w.set([...w.value,{...n,delivered:!1}]),se({content:"",attachments:[]}),ie.current&&(ie.current.value=""),T("info","Updating recent message cache state"),W.APPS.MESSAGES.messages.set(W.APPS.MESSAGES.messages.value.map(R=>R.id===a.id?{...R,timestamp:new Date().getTime(),lastMessage:n.content,unread:!1,deleted:!1}:R))})},ge=()=>{y.PopUp.set({title:i("APPS.MESSAGES.SEND_LOCATION_POPUP.TITLE"),description:i("APPS.MESSAGES.SEND_LOCATION_POPUP.TEXT"),buttons:[{title:i("APPS.MESSAGES.SEND_LOCATION_POPUP.CANCEL")},{title:i("APPS.MESSAGES.SEND_LOCATION_POPUP.SEND"),cb:()=>{U("Maps",{action:"getCurrentLocation"},{x:0,y:0}).then(n=>{if(!n)return;let S={id:a.id,sender:P,content:`<!SENT-LOCATION-X=${Ae(n.x,2)}Y=${Ae(n.y,2)}!>`,attachments:[],timestamp:Date.now()};U("Messages",{action:"sendMessage",number:a.number,content:S.content,attachments:S.attachments,id:S.id},{messageId:Math.random().toString(36).substring(7)}).then(R=>{if(!R)return w.set([...w.value,{...S,delivered:!1}]);w.set([...w.value,{...S,id:R.messageId}])})})}}]})},Ue=()=>{if(O||A)return;let n=document.querySelector("#last");if(!n)return;!Ye(n)&&(M(!0),U("Messages",{action:"getMessages",page:K+1,id:a.id}).then(R=>{if(R&&R.length>0){let j=document.querySelector(".message-container");he.current=j.scrollHeight,w.set([...R.reverse(),...w.value]),M(!1)}else $(!0)}),E(R=>R+1))};d.useEffect(()=>{let n=document.querySelector(".message-container");const S=n.scrollHeight;n.scrollTop+=S-he.current,n.scroll},[b]),re("messages:newMessage",n=>{if(a.id===n.channelId){if(g.airplaneMode)return T("warning","Cannot receive message, airplane mode enabled");w.set([...w.value,{...n,timestamp:Date.now()}])}}),re("messages:renameGroup",n=>{a.id===n.channelId&&(g.airplaneMode||u(S=>({...S,name:n.name})))}),re("messages:messageDeleted",n=>{if(T("info","messages:messageDeleted triggered",n),!n)return T("error","Did not get any data from messages:messageDeleted, returning");if(g.airplaneMode)return T("warning","Cannot update message state, airplane mode enabled");w.set(w.value.filter(S=>S.id!==n.messageId))}),re("messages:removeMember",n=>{a.id===n.channelId&&(g.airplaneMode||n.number===P&&(m("userlist"),u(null)))});const Re=Ce(n=>{if(!p.DeleteMessages)return T("error","Config.DeleteMessages is set to false");let S=n.target;for(;!S.classList.contains("message");)S=S.parentElement;let R=S.getAttribute("data-id");if(!R)return T("error","Failed to get message id when longpressing");let j=b.find(de=>de.id===R);if(!j)return T("error","Failed to find message with id",R);j.sender===P&&(Ge(j.content)||Le(j.content)||ye(j.content)||y.ContextMenu.set({buttons:[{title:i("APPS.MESSAGES.DELETE"),color:"red",cb:()=>{U("Messages",{action:"deleteMessage",channel:a.id,id:R}).then(de=>{if(!de)return T("error","Failed to delete message")})}}]}))}),Le=n=>!n||!p.EnableMessagePay?!1:/<!SENT-PAYMENT-(\d*)!>/.test(n)?!0:!!/<!REQUESTED-PAYMENT-(\d*)!>/.test(n);return e(te,{children:c(B.div,{...we("right","message",.2),className:"animation-container",children:[c(le,{children:[N&&e(Et,{setShow:l,setShowUserInfo:x,sendLocation:ge,setData:u,data:a}),_&&e(ht,{setShow:x,user:a!=null&&a.isGroup?_:a})]}),c("div",{className:"message-header",children:[c("div",{className:"back",onClick:()=>{m("userlist"),u(null),a.unread&&(U("Messages",{action:"markRead",id:a.id}),s(n=>n-1))},children:[e($e,{}),I>0&&e("span",{className:"back-title",children:I})]}),c("div",{className:"user",onClick:()=>{a.isGroup?l(!0):x(!0)},children:[a.isGroup?e("div",{className:"group-avatar","data-hasavatar":(a==null?void 0:a.avatar)!==void 0,style:{backgroundImage:a!=null&&a.avatar?`url(${a.avatar})`:null},children:!(a!=null&&a.avatar)&&c(te,{children:[a.members.sort((n,S)=>n.avatar?1:-1).map((n,S)=>e("div",{className:"avatar",style:{backgroundImage:n!=null&&n.avatar?`url(${n.avatar})`:null,zIndex:a.members.length-S},children:n.name?!(n!=null&&n.avatar)&&ne(n.name):e("img",{src:`./assets/img/avatar-placeholder-${g.display.theme}.svg`,alt:""})},S)).slice(0,5),a.members.length===0&&e("img",{src:`./assets/img/avatar-placeholder-${g.display.theme}.svg`,alt:""})]})}):e("div",{className:"avatar",style:{backgroundImage:a!=null&&a.avatar?`url(${a.avatar})`:null},children:a.name?!(a!=null&&a.avatar)&&ne(a.name):e("img",{src:`./assets/img/avatar-placeholder-${g.display.theme}.svg`,alt:""})}),e("div",{className:"name",children:a.isGroup?a.name??`${a.members.length===0?1:a.members.length} ${i("APPS.MESSAGES.PEOPLE")}`:a.name??Y(a.number)})]}),c("div",{className:"buttons","data-hidden":a.isGroup,children:[e(Ve,{onClick:()=>{a.isGroup||fe({number:a.number})}}),e(xe,{onClick:()=>{a.isGroup||fe({number:a.number,videoCall:!0})}})]})]}),e("div",{className:"message-container",onScroll:Ue,style:L||H?{height:"48%"}:{},children:e("div",{className:"message-body",children:b.map((n,S)=>e(ut,{index:S,messages:b,message:n,longPressEvent:Re}))})}),e("div",{className:"attachments",children:F.attachments.map((n,S)=>c("div",{className:"attachment",children:[Te(n)?e("video",{src:n,muted:!0,controls:!1,loop:!0,autoPlay:!0}):e("img",{src:n}),e(ve,{onClick:()=>{se({...F,attachments:F.attachments.filter((R,j)=>j!==S)})}})]},S))}),c("div",{className:"message-bottom","data-expanded":!!(L||H),children:[e("div",{className:"upper",children:c("div",{className:"input","data-border":!f,children:[f?c("div",{className:"audio-message",children:[e(ve,{onClick:()=>k(null)}),e("div",{className:"audio-waves",children:e("img",{src:f.waves.placeholder})})]}):e(ce,{placeholder:i("APPS.MESSAGES.PLACEHOLDER"),ref:ie,value:F.content,onChange:n=>{se({content:n.target.value,attachments:F.attachments})},onKeyDown:n=>{n.key=="Enter"&&Ee()}}),(F.content.length>0||F.attachments.length>0||f)&&e("div",{className:"send",onClick:Ee,children:e(Ie,{})})]})}),!L&&!H&&e("div",{className:"actions-wrapper",children:c("div",{className:"actions",children:[e("div",{className:"action",onClick:()=>{if(r)return y.Emoji.reset();y.Emoji.set({onSelect:n=>se(S=>({content:`${S.content}${n.emoji}`,attachments:S.attachments}))})},children:"😀"}),e("div",{className:"action",onClick:()=>{var n,S,R;F.attachments.length<3&&y.Gallery.set({includeVideos:!0,allowExternal:(R=(S=(n=X)==null?void 0:n.value)==null?void 0:S.AllowExternal)==null?void 0:R.Messages,onSelect:j=>se({...F,attachments:[...F.attachments,j.src]})})},children:e("img",{src:"./assets/img/icons/messages/gallery.png"})}),e("div",{className:"action small",onClick:()=>{if(h)return y.Gif.reset();y.Gif.set({onSelect:n=>se(S=>({content:S.content,attachments:[...S.attachments,n]}))})},children:"GIF"}),(p==null?void 0:p.EnableMessagePay)&&!a.isGroup&&e("div",{className:"action ",onClick:()=>{G(!1),q(n=>!n)},children:"$"}),e("div",{className:"action",onClick:()=>ge(),children:e(Fe,{})}),(p==null?void 0:p.EnableVoiceMessages)&&e("div",{className:"action",onClick:()=>{q(!1),G(n=>!n)},children:e(be,{})})]})}),e(le,{children:L&&e(ot,{paymentAmount:V,setPaymentAmount:Q,close:()=>q(!1)})}),e(le,{children:H&&e(ct,{onEnd:n=>{if(!n)return T("error","Failed to get audio message data");k({src:URL.createObjectURL(n.blob),blob:n.blob,waves:n.waveform,duration:n.duration}),G(!1)},close:()=>G(!1)})})]})]})})}const ut=({messages:t,message:o,index:v,longPressEvent:g})=>{var x,H;const{User:p}=d.useContext(ae),P=D(z.PhoneNumber),[a]=p,u=D(X);let C,m,I,s,r,h,N=v===0?"last":"",l=o.sender===P?"self":"other",_=((x=t[v+1])==null?void 0:x.sender)===P?"self":"other";if(t[v+1]?I=Math.abs(o.timestamp-t[v+1].timestamp)/36e5:_=void 0,a.isGroup)C=(H=a.members.find(G=>G.number===o.sender))==null?void 0:H.name,m=!t[v-1]||t[v-1].sender!==o.sender;else if(C=a.name,o.content)if(ye(o.content))if(l==="other")o.content=i("APPS.MESSAGES.MISSED_CALL").format({number:o.sender});else return null;else/<!SENT-PAYMENT-(\d*)!>/.test(o.content)?s={amount:o.content.match(/\d/g).join(""),request:!1}:/<!REQUESTED-PAYMENT-(\d*)!>/.test(o.content)&&(s={amount:o.content.match(/\d/g).join(""),request:!0});if(Ge(o.content)){let G=o.content.match(/X=(-?\d*\.?\d*)Y/)[1],L=o.content.match(/Y=(-?\d*\.?\d*)!>/)[1];r={x:G,y:L}}return rt(o.content)&&(h={wave:o.content.match(/AUDIO-MESSAGE-IMAGE="([^"]+)"/)[1],src:o.content.match(/AUDIO="([^"]+)"/)[1],duration:o.content.match(/DURATION="([^"]+)"/)[1]}),c("div",{className:`message ${l}`,id:N,"data-id":o.id,...g,children:[m&&l=="other"&&e("div",{className:"user",children:C??Y(o.sender)}),o.delivered===!1?c("div",{className:"content-wrapper",children:[s&&e("div",{className:"payment",children:u.CurrencyFormat.replace("%s",s.amount)}),!s&&e("div",{className:"content",children:Me(o.content)}),e(He,{})]}):s||r||h?c(te,{children:[r&&c("div",{className:"location",onClick:()=>{y.ContextMenu.set({buttons:[{title:i("APPS.MESSAGES.OPEN_IN_MAPS"),cb:()=>{ue.patch({active:{name:"Maps",data:{location:[r.y,r.x],name:`${C??Y(o.sender)}'s location`,icon:a.avatar}}})}},{title:i("APPS.MAPS.SET_WAYPOINT"),cb:()=>{U("Maps",{action:"setWaypoint",data:{x:r.x,y:r.y}})}}]})},children:[e("div",{className:"img",style:{backgroundImage:'url("https://img.gta5-mods.com/q95/images/mirror-park-garden/2b72f9-20160428154103_1.jpg")'}}),l==="other"&&c("div",{className:"sender",children:[C??Y(o.sender)," ",i("APPS.MESSAGES.SENT_LOCATION")]})]}),s&&e("div",{className:"payment",children:s.request?c("div",{className:`request ${l}`,children:[c("div",{className:"title",children:[u.CurrencyFormat.replace("%s",Ne(s.amount).toString())," ",i("APPS.MESSAGES.PAY.REQUESTED")]}),l==="other"&&e("div",{className:"button",onClick:()=>De(s.amount,{id:a.id,number:a.number,name:a.name}),children:i("APPS.MESSAGES.PAY.PAY")})]}):e("div",{className:"sent",children:u.CurrencyFormat.replace("%s",Ne(s.amount).toString())})}),h&&e(St,{data:h,sender:l})]}):o.content&&e("div",{className:"content",children:Me(o.content)}),o.attachments&&o.attachments.length>0&&e("div",{className:"attatchments",children:o.attachments.map((G,L)=>Te(G)?e("video",{src:G,controls:!1,loop:!0,autoPlay:!0,muted:!0,onClick:q=>y.FullscreenImage.set({display:!0,image:G})},L):e(Oe,{src:G,onClick:()=>y.FullscreenImage.set({display:!0,image:G})},L))}),o.delivered===!1?e("div",{className:"status",children:i("APPS.MESSAGES.NOT_DELIVERED")}):t[v+1]&&I>6?e("div",{className:"date",children:pe(o.timestamp)}):l!==_&&e("div",{className:"date",children:pe(o.timestamp)})]},v)},St=({data:t,sender:o})=>{var C;const[v,g]=d.useState(!1),[p,P]=d.useState(0),a=d.useRef(null);d.useEffect(()=>{a.current&&(a.current.onended=()=>g(!1))},[a]);const u=m=>{m=Math.floor(m);const I=Math.floor(m/60),s=m-I*60;return`${I<10?"0"+I:I}:${s<10?"0"+s:s}`};return c("div",{className:`voice-message ${o}`,children:[e("a",{onClick:()=>{a.current&&(v?(a.current.pause(),a.current.currentTime=0):a.current.play(),g(m=>!m))},children:v?e(je,{}):e(We,{})}),c("div",{className:"wave",children:[e("div",{className:"overlay",style:{width:`${(t.duration-p)/t.duration*100}%`}}),e("img",{src:t.wave,alt:"wave"})]}),e("div",{className:"duration",children:u(v&&Math.floor(((C=a.current)==null?void 0:C.currentTime)+.5)!==0?a.current.currentTime:t.duration)}),e("audio",{ref:a,onTimeUpdate:m=>P(m.currentTarget.currentTime),children:e("source",{src:t.src,type:"audio/mpeg"})})]})},ht=({user:t,setShow:o})=>{const v=D(z.Settings);return c(B.div,{...Se,className:"info-panel",children:[e("div",{className:"info-panel-header",children:e("div",{className:"done",onClick:()=>o(!1),children:i("APPS.MESSAGES.DONE")})}),c("div",{className:"info-panel-body",children:[c("div",{className:"info-panel-top",children:[e("div",{className:"avatar",style:{backgroundImage:t!=null&&t.avatar?`url(${t.avatar})`:null},children:t.name?!(t!=null&&t.avatar)&&ne(t.name):e("img",{src:`./assets/img/avatar-placeholder-${v.display.theme}.svg`,alt:""})}),e("div",{className:"name",children:t.name??Y(t.number)})]}),e("div",{className:"items",children:!t.company&&c(te,{children:[t.name&&e("div",{className:"info-section",children:e("div",{className:"item blue",onClick:()=>qe(t.number),children:Y(t.number)})}),e("div",{className:"info-section",children:t.name?e("div",{className:"item blue",onClick:()=>{y.Share.set({type:"contact",data:{firstname:t.firstname,lastname:t.lastname,number:t.number,avatar:t.avatar}})},children:i("APPS.PHONE.CONTACTS.SHARE_CONTACT")}):e("div",{className:"item blue",onClick:()=>{ue.patch({active:{name:"Phone",data:{view:"newContact",number:t.number}}})},children:i("APPS.PHONE.CONTACTS.ADD_CONTACT")})})]})})]})]})},Et=t=>{const{View:o}=d.useContext(ae),v=D(z.Settings),[g,p]=o,[P,a]=d.useState(t.data.name),[u,C]=d.useState(t.data.avatar);let m=t.data,I=!m.members.find(s=>s.isOwner);return e(te,{children:c(B.div,{...Se,className:"info-panel",children:[c("div",{className:"info-panel-header",children:[e("div",{}),e("div",{className:"close",children:e("div",{className:"button",onClick:()=>t.setShow(!1)})}),e("div",{className:"done",onClick:()=>{P&&P!==""&&P!==m.name?U("Messages",{action:"renameGroup",id:m.id,name:P}).then(s=>{t.setShow(!1)}):t.setShow(!1)},children:i("APPS.MESSAGES.DONE")})]}),c("div",{className:"info-panel-body",children:[c("div",{className:"info-panel-top",children:[u?e(Oe,{className:"group-image",src:u,ignoreStreamerMode:!0}):c("div",{className:"group-avatar",children:[m.members.sort((s,r)=>s.avatar?1:-1).slice(0,10).map((s,r)=>e("div",{className:"avatar",style:{backgroundImage:s!=null&&s.avatar?`url(${s.avatar})`:null,zIndex:m.members.length-r},children:!(s!=null&&s.avatar)&&ne(s.name)},r)),m.members.length===0&&e("img",{src:`./assets/img/avatar-placeholder-${v.display.theme}.svg`,alt:""})]}),e("div",{className:"add-photo",onClick:()=>{var s,r,h;u?y.PopUp.set({title:i("APPS.MESSAGES.REMOVE_AVATAR_POPUP.TITLE"),description:i("APPS.MESSAGES.REMOVE_AVATAR_POPUP.DESCRIPTION"),buttons:[{title:i("APPS.MESSAGES.REMOVE_AVATAR_POPUP.CANCEL")},{title:i("APPS.MESSAGES.REMOVE_AVATAR_POPUP.REMOVE"),color:"red",cb:()=>{U("Messages",{action:"removeGroupAvatar",id:m.id},!0).then(N=>{if(!N)return T("warning","Could not remove group avatar");t.setData(l=>{let _=l;return _.avatar=null,_}),C(null)})}}]}):y.Gallery.set({allowExternal:(h=(r=(s=X)==null?void 0:s.value)==null?void 0:r.AllowExternal)==null?void 0:h.Messages,onSelect:N=>U("Messages",{action:"setGroupAvatar",id:m.id,avatar:N.src},!0).then(l=>{if(!l)return T("warning","Could not set group avatar");t.setData(_=>{let x=_;return x.avatar=N.src,x}),C(N.src)})})},children:u?"Remove Photo":" Add Photo"})]}),c("div",{className:"items",children:[e("div",{className:"info-section",children:c("div",{className:"item blue",children:[e(Xe,{className:"add"}),e(ce,{defaultValue:m.name??i("APPS.MESSAGES.GROUP_NAME"),onChange:s=>a(s.target.value)})]})}),c("div",{className:"subtitle",children:[m.members.length===0?1:m.members.length," ",i("APPS.MESSAGES.MEMBERS")]}),c("div",{className:"info-section",children:[c("div",{className:"item",onClick:()=>y.ContactSelector.set({filter:m.members.map(s=>s.number),onSelect:s=>{if(m.members.find(r=>r.number===s.number))return T("info","User is already in group");U("Messages",{action:"addMember",id:m.id,number:s.number},!0).then(r=>{if(!r)return T("warning","Could not add member to group");t.setData(h=>{let N=h;return N.members.push({...s,name:Z(s.firstname,s.lastname),isOwner:!1}),N})})}}),children:[e(ze,{className:"add"}),e("div",{className:"name",children:i("APPS.MESSAGES.ADD_MEMBER")})]}),m.members.sort((s,r)=>s.name&&!r.name?-1:!s.name&&r.name?1:s.name<r.name?-1:s.name>r.name?1:0).map((s,r)=>c("div",{className:"item",children:[I&&e(Be,{className:"remove",onClick:()=>{y.PopUp.set({title:i("APPS.MESSAGES.REMOVE_POPUP.TITLE"),description:i("APPS.MESSAGES.REMOVE_POPUP.TEXT").format({name:s.name??Y(s.number)}),buttons:[{title:i("APPS.MESSAGES.CANCEL")},{title:i("APPS.MESSAGES.REMOVE_POPUP.REMOVE"),color:"red",cb:()=>{U("Messages",{action:"removeMember",number:s.number,id:m.id}).then(h=>{h&&(t.setData(N=>{let l=N;return l.members=l.members.filter(_=>_.number!==s.number),l}),t.setShow(!1))})}}]})}}),e("div",{className:"avatar",style:{backgroundImage:s!=null&&s.avatar?`url(${s.avatar})`:null},children:!(s!=null&&s.avatar)&&ne(s.name)}),c("div",{className:"details",children:[e("div",{className:"name",children:s.name??Y(s.number)}),s.name&&e("div",{className:"phone-number",children:Y(s.number)})]}),e(Qe,{className:"info",onClick:()=>t.setShowUserInfo({...s})})]},r))]}),e("div",{className:"info-section",children:e("div",{className:"item blue",onClick:()=>t.sendLocation(),children:i("APPS.MESSAGES.SHARE_LOCATION")})}),e("div",{className:"info-section",onClick:()=>{y.PopUp.set({title:i("APPS.MESSAGES.LEAVE_POPUP.TITLE"),description:i("APPS.MESSAGES.LEAVE_POPUP.TEXT"),buttons:[{title:i("APPS.MESSAGES.CANCEL")},{title:i("APPS.MESSAGES.LEAVE_POPUP.LEAVE"),color:"red",cb:()=>{U("Messages",{action:"leaveGroup",id:m.id}).then(s=>{if(!s)return T("info","Failed to leave group, server didnt callback request");p("userlist"),t.setShow(!1)})}}]})},children:c("div",{className:"item red",children:[e(Ke,{}),i("APPS.MESSAGES.LEAVE_GROUP")]})})]})]})]})})};function gt(){const{User:t,View:o,Newmessage:v,ImportedUser:g}=d.useContext(ae),[p,P]=t,[a,u]=o,[C,m]=g,I=D(z.Settings),s=D(z.PhoneNumber),[r,h]=v,N=D(W.APPS.PHONE.contacts),[l,_]=d.useState([]),x=d.useRef(null),[H,G]=d.useState(""),[L,q]=d.useState([]),[V,Q]=d.useState({content:"",attachments:[]});d.useEffect(()=>{C&&(_([C]),m(null))},[C]);const K=()=>{(V.content.length>0||V.attachments.length>0)&&(l.length>1?U("Messages",{action:"createGroup",members:l,content:V.content,attachments:V.attachments}).then(E=>{if(!E)return T("error","Failed to create group");P({isGroup:!0,members:l.map(O=>{let $=Z(O.firstname,O.lastname);return{...O,name:$}}),lastMessage:V.content,timestamp:Date.now(),id:E.channelId}),u("messages"),h(!1)}):U("Messages",{action:"sendMessage",number:l[0].number,content:V.content,attachments:V.attachments}).then(E=>{var A,M,b,f;if(!E)return T("error","Failed to send message");let O;l[0].name?O=l[0].name:(A=l[0])!=null&&A.firstname&&(O=Z((M=l[0])==null?void 0:M.firstname,(b=l[0])==null?void 0:b.lastname));let $={number:l[0].number,name:O,avatar:(f=l[0])==null?void 0:f.avatar};P({...$,lastMessage:V.content,timestamp:Date.now(),id:E.channelId}),u("messages"),h(!1)}))};return d.useEffect(()=>{if(H.length>0){if(N){const E=N.filter(O=>{let $=Z(O.firstname,O.lastname);return $&&$.toLowerCase().includes(H.toLowerCase())&&!O.company});q(E)}}else q([])},[H]),c(B.div,{...Se,className:"new-message-container",children:[c("div",{className:"new-message-header",children:[e("span",{}),e("div",{className:"title",children:i("APPS.MESSAGES.NEW_MESSAGE")}),e("div",{className:"button",onClick:()=>{l.length>0&&(V.content.length>0||V.attachments.length>0)?K():h(!1)},children:l.length>0&&(V.content.length>0||V.attachments.length>0)?i("APPS.MESSAGES.SEND"):i("APPS.MESSAGES.CANCEL")})]}),c("div",{className:"new-message-body",children:[c("div",{className:"new-message-search",children:[c("div",{className:"to",children:[i("APPS.MESSAGES.TO"),":"]}),e("div",{className:"contacts",children:l.map((E,O)=>{let $=Z(E.firstname,E.lastname),A=$!=="Unknown";return e("div",{className:`contact ${A?"green":"blue"}`,onClick:()=>{y.PopUp.set({title:i("APPS.MESSAGES.REMOVE_POPUP.TITLE"),description:i("APPS.MESSAGES.REMOVE_POPUP.TEXT").format({NAME:$??Y(E.number)}),buttons:[{title:i("APPS.MESSAGES.CANCEL")},{title:i("APPS.MESSAGES.REMOVE_POPUP.REMOVE"),color:"red",cb:()=>{let M=l.filter(b=>b.number!==E.number);_(M)}}]})},children:A?$:Y(E.number)},O)})}),e(ce,{type:"text",ref:x,onChange:E=>{if(G(E.target.value),E.target.value.length==s.length&&/^\d+$/g.test(E.target.value)){if(E.target.value===s||l.find($=>$.number==E.target.value))return;_([...l,{number:E.target.value}]),x.current.value="",G("")}},onKeyDown:E=>{var O;E.key=="Backspace"&&H.length==0?((O=l[l.length-1])==null?void 0:O.name)===void 0?(x.current.value=l[l.length-1].number,_(l.slice(0,l.length-1))):_(l.slice(0,-1)):E.key=="Tab"&&(E.preventDefault(),L.length==1&&(_([...l,L[0]]),x.current.value="",G("")))}})]}),e("div",{className:"search-results",children:L&&L.filter(E=>!l.find(O=>O.number==E.number)).map((E,O)=>{let $=Z(E.firstname,E.lastname);return c("div",{className:"contact",onClick:()=>{l.find(M=>M.number==E.number)||(_([...l,E]),x.current.value="",G(""))},children:[e("img",{src:E.avatar??`./assets/img/avatar-placeholder-${I.display.theme}.svg`}),c("div",{className:"user",children:[e("div",{className:"name",children:$}),e("div",{className:"number",children:Y(E.number)})]})]},O)})})]}),l.length>0&&L.length===0&&e("div",{className:"message-bottom absolute",children:e("div",{className:"upper",children:c("div",{className:"input",children:[e(ce,{placeholder:i("APPS.MESSAGES.PLACEHOLDER"),value:V.content,onChange:E=>{Q({content:E.target.value??"",attachments:V.attachments})},onKeyDown:E=>{E.key=="Enter"&&K()}}),(V.content.length>0||V.attachments.length>0)&&e("div",{className:"send",onClick:()=>K(),children:e(Ie,{})})]})})})]})}const J=me([]),ee=me([]);function ft(){var $;const{User:t,View:o,Newmessage:v,UnreadMessages:g,ImportedUser:p}=d.useContext(ae),P=D(z.PhoneNumber),a=D(z.Settings),u=($=D(ue))==null?void 0:$.active,[C,m]=t,[I,s]=o,[r,h]=p,[N,l]=v,[_,x]=g,H=D(W.APPS.PHONE.contacts),G=D(W.APPS.MESSAGES.messages),L=D(J),[q,V]=d.useState(""),[Q,K]=d.useState(!1),E=D(ee);d.useEffect(()=>{G?(T("info","Using cache for recent messages"),J.set(G),x(L.filter(A=>A.unread).length)):U("Messages",{action:"getRecentMessages"},ke.Messagelist).then(A=>{let M=A.map(b=>{if(b.isGroup)return b.members=b.members.filter(f=>f.number!==P).map(f=>{let k=H.find(ie=>ie.number===f.number);return{name:k&&k.firstname?Z(k==null?void 0:k.firstname,k==null?void 0:k.lastname):void 0,avatar:k==null?void 0:k.avatar,blocked:k==null?void 0:k.blocked,favourite:k==null?void 0:k.favourite,number:f.number,isOwner:f.isOwner}}),b;{let f=H.find(k=>k.number===b.number);return b.name=f!=null&&f.lastname?`${f.firstname} ${f.lastname}`:f==null?void 0:f.firstname,b.avatar=f==null?void 0:f.avatar,b}});x(M.filter(b=>b.unread).length),J.set(M),T("info","setting cache"),W.APPS.MESSAGES.messages.set(M)})},[G]);let O=d.useRef(!1);return d.useEffect(()=>{var A;if(!O.current&&u!=null&&u.data&&(O.current=!0,u!=null&&u.data&&((A=u.data)==null?void 0:A.view)=="messages")){let M=L.find(b=>b.number===u.data.number);M?(m(M),s("messages")):(l(!0),h({number:u.data.number,name:u.data.name,avatar:u.data.avatar}))}},[u==null?void 0:u.data,L]),re("messages:newMessage",A=>{let M=JSON.parse(JSON.stringify(L)),b=M.findIndex(f=>f.id===A.channelId);a.airplaneMode||(b!==-1&&M.unshift(M.splice(b,1)[0]),M[0].lastMessage=A.content,M[0].timestamp=new Date,J.set(M))}),c(te,{children:[e(le,{children:N&&e(gt,{})}),c(B.div,{...we("left","messagelist",.2),className:"animation-container",children:[c("div",{className:"messages-header",children:[c("div",{className:"buttons",children:[e("div",{className:"edit",onClick:()=>K(!Q),children:Q?i("APPS.MESSAGES.DONE"):i("APPS.MESSAGES.EDIT")}),e(Je,{"data-disabled":Q,onClick:()=>l(!0)})]}),e("div",{className:"title",children:i("APPS.MESSAGES.TITLE")})]}),e(Ze,{placeholder:i("SEARCH"),onChange:A=>V(A.target.value)}),e("div",{className:"users-list",children:L.filter(A=>{var M;return A.deleted?!1:(A.isGroup?A.members.find(b=>{var f;return((f=b.name)==null?void 0:f.toLowerCase().includes(q.toLowerCase()))||b.number.includes(q)}):((M=A.name)==null?void 0:M.toLowerCase().includes(q.toLowerCase()))||A.number.includes(q))||A.lastMessage.toLowerCase().includes(q.toLowerCase())}).sort((A,M)=>M.timestamp-A.timestamp).map((A,M)=>e(vt,{user:A,editMode:Q,onClick:()=>{if(m(A),s("messages"),A.unread){U("Messages",{action:"markRead",id:A.id},!0),x(f=>f-1);let b=W.APPS.MESSAGES.messages.value;W.APPS.MESSAGES.messages.set(b.map(f=>(f.id===A.id&&(f.unread=!1),f)))}}},M))}),e(le,{children:Q&&c(B.div,{initial:{opacity:0,y:50},animate:{opacity:1,y:0},exit:{opacity:0,y:50},transition:{duration:.2,ease:"easeInOut"},className:"messages-footer",children:[e("div",{className:"button","data-disabled":!0,children:i("APPS.MESSAGES.READ")}),e("div",{className:"button",onClick:()=>{if(E.length===0)return T("info","No messages selected, can't delete");y.PopUp.set({title:i("APPS.MESSAGES.DELETE_CONVERSATION.TITLE"),description:i("APPS.MESSAGES.DELETE_CONVERSATION.DESCRIPTION"),buttons:[{title:i("APPS.MESSAGES.CANCEL")},{title:i("APPS.MESSAGES.DELETE"),cb:()=>{U("Messages",{action:"deleteConversations",channels:E},!0).then(A=>{if(!A)return T("error","Failed to delete conversations");K(!1),J.set(L.filter(M=>!E.includes(M.id))),W.APPS.MESSAGES.messages.set([...W.APPS.MESSAGES.messages.value.map(M=>(E.includes(M.id)&&(M.deleted=!0),M))]),ee.set([])})}}]})},children:i("APPS.MESSAGES.DELETE")})]})})]})]})}const vt=({user:t,editMode:o,onClick:v})=>{var I,s;const g=D(X),p=D(z.Settings),P=D(J),[a,u]=d.useState(!1);let C;const m=Ce(r=>{y.ContextMenu.set({buttons:[{title:i("APPS.MESSAGES.MARK_AS_READ"),cb:()=>{U("Messages",{action:"markRead",id:t.id},!0).then(h=>{if(!h)return T("error","Failed to mark message as read");J.set(P.map(l=>(l.id===t.id&&(l.unread=!1),l)));let N=W.APPS.MESSAGES.messages.value;W.APPS.MESSAGES.messages.set(N.map(l=>(l.id===t.id&&(l.unread=!1),l)))})}},{title:i("APPS.MESSAGES.DELETE_CONVERSATION.TITLE"),color:"red",cb:()=>{y.PopUp.set({title:i("APPS.MESSAGES.DELETE_CONVERSATION.TITLE"),description:i("APPS.MESSAGES.DELETE_CONVERSATION.DESCRIPTION"),buttons:[{title:i("APPS.MESSAGES.CANCEL")},{title:i("APPS.MESSAGES.DELETE"),cb:()=>{U("Messages",{action:"deleteConversations",channels:[t.id]},!0).then(h=>{if(!h)return T("error","Failed to delete conversations");J.set(P.filter(N=>N.id!==t.id)),W.APPS.MESSAGES.messages.set([...W.APPS.MESSAGES.messages.value.map(N=>(N.id===t.id&&(N.deleted=!0),N))]),ee.set([])})}}]})}}]})});if(t.isGroup?t.name?C=t.name:t.members.length===0?C=i("APPS.MESSAGES.GROUP"):C=t.members.sort((r,h)=>r.name&&!h.name?-1:!r.name&&h.name?1:r.name<h.name?-1:r.name>h.name?1:0).map((r,h)=>{if(h<2)return r.name?r.name:Y(r.number);if(h===2)return`+${t.members.length-2} ${i("APPS.MESSAGES.OTHER").toLowerCase()}`}).join(", "):C=t.name,t.lastMessage){if(t.lastMessage==="Attachment"&&(t.lastMessage=i("APPS.MESSAGES.SENT_A_PHOTO")),/<!SENT-PAYMENT-(\d*)!>/.test(t.lastMessage)){let r=t.lastMessage.match(/\d/g).join("");t.lastMessage=`${i("APPS.MESSAGES.SENT")} ${g.CurrencyFormat.replace("%s",r)}`}else if(/<!REQUESTED-PAYMENT-(\d*)!>/.test(t.lastMessage)){let r=t.lastMessage.match(/\d/g).join("");t.lastMessage=`${i("APPS.MESSAGES.REQUESTED")} $${r}`}else if(/<!SENT-LOCATION-X=(-?\d*\.?\d*)Y=(-?\d*\.?\d*)!>/.test(t.lastMessage))t.lastMessage=`${i("APPS.MESSAGES.SENT_LOCATION_SHORT")}`;else if(t.lastMessage.startsWith('<!AUDIO-MESSAGE-IMAGE="'))t.lastMessage=i("APPS.MESSAGES.SENT_AUDIO_MESSAGE");else if(t.lastMessage==="<!CALL-NO-ANSWER!>")t.lastMessage=i("APPS.MESSAGES.TRIED_TO_CALL").format({number:Y(t.number)});else if(t.lastMessage==="")return}return d.useEffect(()=>{a?ee.set([...ee.value,t.id]):ee.set(ee.value.filter(r=>r!==t.id))},[a]),c(B.div,{initial:{opacity:0,scale:.9},whileInView:{opacity:1,scale:1},viewport:{once:!0},className:"user",...m,onClick:()=>{o?u(!a):v()},children:[c("div",{className:"items",children:[o&&e(B.div,{initial:{opacity:0,scale:.9},animate:{opacity:1,scale:1},exit:{opacity:0,scale:.9},className:"check","data-checked":a,onClick:r=>{r.stopPropagation(),u(!a)},children:a&&e(et,{})},"check"),e("div",{className:tt("dot",t.unread&&"unread")})]}),t.isGroup?c("div",{className:"avatar group",children:[t.members.map((r,h)=>{if(h<=3)return r.avatar?e("div",{style:{backgroundImage:`url(${r.avatar})`}},h):r.name?e("div",{children:r.name.charAt(0)},h):e("div",{className:"unknown"},h)}),t.members.length===0&&e("img",{className:"avatar",src:`assets/img/avatar-placeholder-${p.display.theme}.svg`})]}):e("div",{className:"avatar",style:{backgroundImage:t!=null&&t.avatar?`url(${t.avatar})`:null},children:t.name?!(t!=null&&t.avatar)&&ne(t.name):e("img",{src:`assets/img/avatar-placeholder-${p.display.theme}.svg`,alt:""})}),c("div",{className:"user-body",children:[c("div",{className:"user-header",children:[e("div",{className:"name",children:C??Y(t.number)}),c("div",{className:"right",children:[e("div",{className:"time",children:at(t.timestamp)}),e(st,{})]})]}),e("div",{className:"content",children:((I=t.lastMessage)==null?void 0:I.length)>40?((s=t.lastMessage)==null?void 0:s.substring(0,40))+"...":t.lastMessage})]})]})};const ae=d.createContext(null);function Mt(){const[t,o]=d.useState(null),[v,g]=d.useState("userlist"),[p,P]=d.useState(null),[a,u]=d.useState(0),[C,m]=d.useState(!1);return e("div",{className:"messages-container","data-view":v,children:e(ae.Provider,{value:{User:[t,o],View:[v,g],Newmessage:[C,m],ImportedUser:[p,P],UnreadMessages:[a,u]},children:v=="userlist"?e(ft,{}):e(mt,{})})})}export{ae as MessagesContext,Mt as default};
