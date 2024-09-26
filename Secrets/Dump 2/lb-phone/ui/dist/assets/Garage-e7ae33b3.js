import{r as u,p as P,q as R,j as a,a as e,m as G,F as r,bP as S,bE as E,L as s,S as g,x as n,bQ as O,aN as f,bR as C,bS as I,bT as T,u as k,C as h,bU as L,J as U,aF as y,bV as V,bW as _,bK as D,bX as B,bY as M,bz as F,bL as K,W as x,ac as W,b as X}from"./index-2acb14b9.js";const Y={vehicles:[{type:"car",name:"Blista Compact",plate:"49XJL722",model:"Blista Compact",location:"Richman Glen",impounded:!1,locked:!1,statistics:{engine:100,body:100,fuel:100}},{type:"car",name:"Buccaneer",plate:"49XJL723",model:"Buccaneer",location:"Buccaneer Way",impounded:!1,locked:!0,statistics:{engine:87,body:98,fuel:53}},{type:"car",name:"Buffalo",plate:"49XJL724",model:"Buffalo",location:"Grove Street",impounded:!0,locked:!1,statistics:{engine:100,body:100,fuel:100},impoundReason:{reason:"Parking Violation",retrievable:0,price:250,impounder:"Police Department"}}]};function J(){const[t,d]=u.useState(null),[c,i]=u.useState([]);u.useEffect(()=>{P("Garage",{action:"getVehicles"},Y.vehicles).then(l=>{if(!l)return R("info","No response from getVehicles");i(l)})},[]);const o={car:e(E,{}),boat:e(O,{}),plane:e(f,{}),bike:e(C,{}),truck:e(I,{}),train:e(T,{})};return a("div",{className:"garage-container",style:{backgroundImage:"url(./assets/img/backgrounds/default/apps/garage/2.jpg)"},children:[e(G.div,{animate:{backdropFilter:"blur(10px) brightness(0.75)"},exit:{backdropFilter:"inherit"},transition:{duration:1},className:"blur-overlay"}),e("div",{className:"garage-header",children:t?a(r,{children:[e("div",{className:"title",children:t.model}),e(S,{className:"close",onClick:()=>d(null)})]}):a("div",{className:"title",children:[e(E,{})," ",s("APPS.GARAGE.MY_CARS")]})}),e(G.div,{...g(t?"right":"left",t?"home":"homes",.2),className:"garage-wrapper",children:t?e(j,{Vehicle:[t,d],Vehicles:[c,i]}):a(r,{children:[c.filter(l=>l.location==="out"&&!l.impounded).length>0&&a(r,{children:[a("div",{className:"subtitle",children:[s("APPS.GARAGE.OUT"),e(n,{})]}),e("section",{children:c.filter(l=>l.location==="out"&&!l.impounded).map(l=>a("div",{className:"item small",onClick:()=>d(l),children:[e("div",{className:"icon blue",children:o[l.type]}),a("div",{className:"info",children:[e("div",{className:"title",children:l.model}),e("div",{className:"value",children:l.plate})]})]},l.plate))})]}),c.filter(l=>l.location!=="out"&&!l.impounded).length>0&&a(r,{children:[a("div",{className:"subtitle",children:[s("APPS.GARAGE.GARAGE"),e(n,{})]}),e("section",{children:c.filter(l=>l.location!=="out"&&!l.impounded).map((l,N)=>a("div",{className:"item small",onClick:()=>d(l),children:[e("div",{className:"icon blue",children:o[l.type]}),a("div",{className:"info",children:[e("div",{className:"title",children:l.model}),a("div",{className:"value",children:[l.plate," - ",l.location]})]})]},l.plate))})]}),c.filter(l=>l.impounded).length>0&&a(r,{children:[a("div",{className:"subtitle",children:[s("APPS.GARAGE.IMPOUNDED"),e(n,{})]}),e("section",{children:c.filter(l=>l.impounded).map((l,N)=>a("div",{className:"item small",onClick:()=>d(l),children:[e("div",{className:"icon blue",children:o[l.type]}),a("div",{className:"info",children:[e("div",{className:"title",children:l.model}),a("div",{className:"value",children:[l.plate," - ",l.location]})]})]},l.plate))})]})]})})]})}const j=({Vehicle:t,Vehicles:d})=>{var p,v;const c=k(X),[i,o]=t,[l,N]=d;return a("div",{className:"options-container",children:[a("div",{className:"grid-wrapper",children:[a("div",{className:"subtitle",children:[s("APPS.GARAGE.ACTIONS"),e(n,{})]}),a("div",{className:"grid",children:[a("div",{className:"item big",onClick:()=>{h.PopUp.set({title:s("APPS.GARAGE.WAYPOINT_POPUP.TITLE"),description:s("APPS.GARAGE.WAYPOINT_POPUP.TEXT").format({model:i.model}),buttons:[{title:s("APPS.GARAGE.WAYPOINT_POPUP.CANCEL")},{title:s("APPS.GARAGE.WAYPOINT_POPUP.PROCEED"),cb:()=>{P("Garage",{action:"setWaypoint",plate:i.plate})}}]})},children:[e("div",{className:"icon blue",children:e(L,{})}),a("div",{className:"info",children:[e("div",{className:"title",children:s("APPS.GARAGE.LOCATION")}),e("div",{className:"value",children:U(i.location==="out"?s("APPS.GARAGE.OUT"):i.location)})]})]}),i.locked!==void 0&&a("div",{className:"item big","data-active":i.locked,onClick:()=>{h.PopUp.set({title:s("APPS.GARAGE.LOCK_POPUP.TITLE").format({toggle:i.locked?s("APPS.GARAGE.UNLOCK"):s("APPS.GARAGE.LOCK")}),description:s("APPS.GARAGE.LOCK_POPUP.TEXT").format({toggle:(i.locked?s("APPS.GARAGE.UNLOCK"):s("APPS.GARAGE.LOCK")).toLowerCase()}),buttons:[{title:s("APPS.GARAGE.LOCK_POPUP.CANCEL")},{title:s("APPS.GARAGE.LOCK_POPUP.PROCEED"),cb:()=>{P("Garage",{action:"toggleLocked",plate:i.plate},!i.locked).then(b=>{b!==void 0&&(N(m=>m.map(A=>A.plate===i.plate?{...A,locked:!A.locked}:A)),o(m=>({...m,locked:!m.locked})))})}}]})},children:[e("div",{className:"icon blue",children:e(y,{})}),a("div",{className:"info",children:[e("div",{className:"title",children:s("APPS.GARAGE.STATUS")}),e("div",{className:"value",children:i.locked?s("APPS.GARAGE.LOCKED"):s("APPS.GARAGE.UNLOCKED")})]})]}),((p=c==null?void 0:c.valet)==null?void 0:p.enabled)&&i.location!=="out"&&!i.impounded&&i.type==="car"&&a("div",{className:"item big",onClick:()=>{h.PopUp.set({title:s("APPS.GARAGE.VALET_POPUP.TITLE"),description:c.valet.price&&c.valet.price>0?s("APPS.GARAGE.VALET_POPUP.TEXT_PAID").format({model:i.model,plate:i.plate,amount:c.valet.price}):s("APPS.GARAGE.VALET_POPUP.TEXT").format({model:i.model,plate:i.plate}),buttons:[{title:s("APPS.GARAGE.VALET_POPUP.CANCEL")},{title:s("APPS.GARAGE.VALET_POPUP.PROCEED"),cb:()=>{P("Garage",{action:"valet",plate:i.plate})}}]})},children:[e("div",{className:"icon blue",children:e(V,{})}),a("div",{className:"info",children:[e("div",{className:"title",children:s("APPS.GARAGE.SUMMON")}),e("div",{className:"value",children:s("APPS.GARAGE.VALET")})]})]})]})]}),i.statistics&&Object.keys(i.statistics).length>0&&a("div",{className:"grid-wrapper",children:[a("div",{className:"subtitle",children:[s("APPS.GARAGE.STATISTICS"),e(n,{})]}),a("div",{className:"grid",children:[i.statistics.fuel&&a("div",{className:"item small",children:[e("div",{className:"icon blue",children:e(_,{})}),a("div",{className:"info",children:[e("div",{className:"title",children:s("APPS.GARAGE.FUEL")}),a("div",{className:"value",children:[i.statistics.fuel,"%"]})]})]}),i.statistics.engine&&a("div",{className:"item small",children:[e("div",{className:"icon blue",children:e(D,{})}),a("div",{className:"info",children:[e("div",{className:"title",children:s("APPS.GARAGE.ENGINE")}),a("div",{className:"value",children:[i.statistics.engine,"%"]})]})]}),i.statistics.body&&a("div",{className:"item small",children:[e("div",{className:"icon blue",children:e(B,{})}),a("div",{className:"info",children:[e("div",{className:"title",children:s("APPS.GARAGE.BODY")}),a("div",{className:"value",children:[i.statistics.body,"%"]})]})]})]})]}),i.impounded&&i.impoundReason&&Object.keys(i.impoundReason).length>0&&a("div",{className:"grid-wrapper",children:[a("div",{className:"subtitle",children:[s("APPS.GARAGE.IMPOUND_INFO"),e(n,{})]}),a("div",{className:"grid",children:[i.impoundReason.reason&&a("div",{className:"item big",children:[e("div",{className:"icon blue",children:e(M,{})}),a("div",{className:"info",children:[e("div",{className:"title",children:s("APPS.GARAGE.IMPOUND_REASON.REASON")}),e("div",{className:"value",children:i.impoundReason.reason})]})]}),i.impoundReason.impounder&&a("div",{className:"item big",children:[e("div",{className:"icon blue",children:e(F,{})}),a("div",{className:"info",children:[e("div",{className:"title",children:s("APPS.GARAGE.IMPOUND_REASON.IMPOUNDER")}),e("div",{className:"value",children:i.impoundReason.impounder})]})]}),i.impoundReason.price!==void 0&&a("div",{className:"item small",children:[e("div",{className:"icon blue",children:e(K,{})}),a("div",{className:"info",children:[e("div",{className:"title",children:s("APPS.GARAGE.IMPOUND_REASON.PRICE")}),e("div",{className:"value",children:(v=c==null?void 0:c.CurrencyFormat)==null?void 0:v.replace("%s",i.impoundReason.price.toString())})]})]}),i.impoundReason.retrievable&&a("div",{className:"item small",children:[e("div",{className:"icon blue",children:e(x,{})}),a("div",{className:"info",children:[e("div",{className:"title",children:s("APPS.GARAGE.IMPOUND_REASON.RETRIEVABLE")}),e("div",{className:"value",children:W(i.impoundReason.retrievable)})]})]})]})]})]})};export{J as default};
