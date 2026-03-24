((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,C,D,A={fj:function fj(d,e){this.a=d
this.$ti=e},vT:function vT(){},
Iz(d,e,f,g){var x=C.A(y.w,y.a)
x.l(0,"click",new A.IA(y.z.a(e)))
return x},
IA:function IA(d){this.a=d},
ym:function ym(d){this.a=d},
yj:function yj(d,e,f){this.f=d
this.Q=e
this.a=f},
RK(){return new A.hD(null)},
hD:function hD(d){this.a=d},
kr:function kr(d){this.a=d},
os:function os(d){var _=this
_.d=d
_.c=_.a=_.f=_.e=null},
H4:function H4(d){this.a=d},
H0:function H0(d,e){this.a=d
this.b=e},
H2:function H2(d,e){this.a=d
this.b=e},
H3:function H3(d){this.a=d},
H1:function H1(d,e){this.a=d
this.b=e},
fG:function fG(d,e){this.a=d
this.b=e},
jK:function jK(d,e){this.a=d
this.b=e},
cH:function cH(d,e){this.a=d
this.b=e},
tS:function tS(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.c=$
_.d=0
_.e=f
_.f=g
_.r=h},
TW(d){var x=null
return new C.kf(x,x,!1,x,x,d)}},B,E,G,F
J=c[1]
C=c[0]
D=c[2]
A=a.updateHolder(c[3],A)
B=c[16]
E=c[13]
G=c[11]
F=c[8]
A.fj.prototype={
b3(d,e){return new A.fj(J.yv(this.a,e),e.h("fj<0>"))},
gp(d){return J.bY(this.a)},
j(d,e){return J.pc(this.a,C.P(e))}}
A.vT.prototype={
vo(d){if(d<=0||d>4294967296)throw C.j(A.TW("max must be in range 0 < max \u2264 2^32, was "+d))
return Math.random()*d>>>0},
$iTV:1}
A.ym.prototype={
a0(d){var x=null
return new C.b9("h1",x,x,x,x,x,B.qj,x)}}
A.yj.prototype={
a0(d){var x=null,w=y.w,v=C.A(w,y.a)
v.D(0,A.XD().$1$1$onClick(this.f,y.v))
return new C.b9("button",x,x,x,C.A(w,w),v,this.Q,x)}}
A.hD.prototype={
a0(d){return B.vF}}
A.kr.prototype={
bv(){var x=C.e([],y.y)
x=new A.tS(B.oB,x,B.aF,B.aC,B.aC)
x.qI()
return new A.os(x)}}
A.os.prototype={
aX(){this.ip()
var x=C.d8(new A.H4(this))
this.f=x
C.c(b.G.document).addEventListener("keydown",x)},
A(){var x,w=this,v=w.e
if(v!=null)v.ar()
x=w.f
if(x!=null){C.c(b.G.document).removeEventListener("keydown",x)
w.f=null}w.kS()},
Bd(d){var x,w=this,v={}
v.a=null
switch(C.z(d.key)){case"ArrowUp":x=v.a=B.ds
break
case"ArrowDown":x=v.a=B.dt
break
case"ArrowLeft":x=v.a=B.du
break
case"ArrowRight":x=v.a=B.aC
break
default:x=null}if(x==null){if(w.d.e===B.aG&&C.z(d.key)==="r")w.rn()
return}d.preventDefault()
switch(w.d.e.a){case 0:w.Do(x)
break
case 1:w.bd(new A.H0(v,w))
break
case 2:break}},
Do(d){var x=this
x.bd(new A.H2(x,y.x.a(d)))
x.e=G.NP(B.p_,new A.H3(x))},
rn(){var x=this,w=x.e
if(w!=null)w.ar()
x.e=null
x.bd(x.d.gHV())},
zn(d,e){var x=new A.cH(d,e),w=this.d,v=w.b,u=y.f,t=new A.fj(v,u)
if(!t.gF(t)){t=new A.fj(v,u)
t=t.gM(t).m(0,x)}else t=!1
if(t)return"cell head"
v=new A.fj(v,u)
if(v.t(v,x))return"cell body"
if(w.e!==B.aF){w=w.c
w===$&&C.f()
w=w.m(0,x)}else w=!1
if(w)return"cell food"
return"cell"},
a0(d){var x,w,v,u=null,t=this.d,s=y.F,r=F.hp(C.e([new C.aJ("Score: "+t.d,u)],s),"score"),q=C.e([],s)
for(x=0;x<20;++x){w=C.e([],s)
for(v=0;v<20;++v)w.push(new E.j4(u,this.zn(v,x),u,B.qD,u))
q.push(new E.j4(u,"row",u,w,u))}r=C.e([B.xj,r,E.dA(q,"grid",u,u,u)],s)
q=t.e
if(q===B.aF)r.push(B.xp)
else if(q===B.aG)r.push(E.dA(C.e([F.hp(C.e([new C.aJ("Game Over!  Score: "+t.d,u)],s),u),new A.yj(this.gCV(),B.qU,u),B.xq],s),"game-over",u,u,u))
return E.dA(r,"snake-game",u,u,u)}}
A.fG.prototype={
C(){return"Direction."+this.b}}
A.jK.prototype={
C(){return"GameState."+this.b}}
A.cH.prototype={
m(d,e){var x,w=this
if(e==null)return!1
if(w!==e)x=e instanceof A.cH&&C.Y(w)===C.Y(e)&&w.a===e.a&&w.b===e.b
else x=!0
return x},
gq(d){return C.ac(this.a,this.b,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a)}}
A.tS.prototype={
kC(){if(this.e!==B.aF)return
this.e=B.dE},
ew(){var x,w,v,u,t,s=this
if(s.e!==B.dE)return
s.f=s.r
x=s.b
w=D.b.gM(x)
switch(s.f.a){case 0:v=new A.cH(w.a,w.b-1)
break
case 1:v=new A.cH(w.a,w.b+1)
break
case 2:v=new A.cH(w.a-1,w.b)
break
case 3:v=new A.cH(w.a+1,w.b)
break
default:v=null}u=v.a
t=!0
if(u>=0)if(u<20){u=v.b
u=u<0||u>=20}else u=t
else u=t
if(u){s.e=B.aG
return}if(D.b.t(D.b.dU(x,0,x.length-1),v)){s.e=B.aG
return}D.b.f5(x,0,v)
u=s.c
u===$&&C.f()
if(v.m(0,u)){++s.d
s.r0()}else{if(0>=x.length)return C.b(x,-1)
x.pop()}},
tL(d){var x,w=this
switch(d.a){case 0:x=w.f===B.dt
break
case 1:x=w.f===B.ds
break
case 2:x=w.f===B.aC
break
case 3:x=w.f===B.du
break
default:x=null}if(!x)w.r=d},
fh(){return this.qI()},
qI(){var x=this,w=x.b
D.b.B(w)
D.b.D(w,C.e([B.v6,B.v8,B.v7],y.y))
x.r=x.f=B.aC
x.d=0
x.e=B.aF
x.r0()},
r0(){var x,w=this.a,v=this.b,u=0
do{x=new A.cH(w.vo(20),w.vo(20));++u}while(D.b.t(v,x)&&u<400)
this.c=x}}
var z=a.updateTypes(["~()","S<i,~(E)>({onChange:~(0^)?,onClick:~()?,onInput:~(0^)?})<v?>"])
A.IA.prototype={
$1(d){var x
C.c(d)
x=C.C(d.target)
x=x==null?!1:x instanceof $.Qv()
if(x)d.preventDefault()
this.a.$0()},
$S:1}
A.H4.prototype={
$1(d){d.toString
this.a.Bd(C.c(d))},
$S:25}
A.H0.prototype={
$0(){var x=this.a.a
x.toString
return this.b.d.tL(x)},
$S:0}
A.H2.prototype={
$0(){var x=this.a.d
x.kC()
x.tL(this.b)},
$S:0}
A.H3.prototype={
$1(d){var x
y.g.a(d)
x=this.a
x.bd(new A.H1(x,x.d.d))},
$S:30}
A.H1.prototype={
$0(){var x=this.a,w=x.d
w.ew()
if(w.d>this.b)x.a.toString
if(w.e===B.aG){w=x.e
if(w!=null)w.ar()
x.e=null}},
$S:0};(function installTearOffs(){var x=a.installStaticTearOff,w=a._instance_0u
x(A,"XD",0,null,["$1$3$onChange$onClick$onInput","$0","$1$0","$1$1$onClick"],["Iz",function(){return A.Iz(null,null,null,y.b)},function(d){return A.Iz(null,null,null,d)},function(d,e){return A.Iz(null,d,null,e)}],1,0)
w(A.os.prototype,"gCV","rn",0)
w(A.tS.prototype,"gHV","fh",0)})();(function inheritance(){var x=a.inherit,w=a.inheritMany
x(A.fj,C.iK)
w(C.v,[A.vT,A.cH,A.tS])
w(C.cv,[A.IA,A.H4,A.H3])
w(E.bu,[A.ym,A.yj,A.hD])
x(A.kr,E.dr)
x(A.os,E.bV)
w(C.eb,[A.H0,A.H2,A.H1])
w(C.he,[A.fG,A.jK])})()
C.eD(b.typeUniverse,JSON.parse('{"fj":{"a0":["1"],"ew":["1"],"t":["1"],"W":["1"],"o":["1"],"a0.E":"1","ew.E":"1"},"vT":{"TV":[]},"ym":{"bu":[],"ap":[]},"yj":{"bu":[],"ap":[]},"hD":{"bu":[],"ap":[]},"kr":{"dr":[],"ap":[]},"os":{"bV":["kr"],"bV.T":"kr"},"fG":{"M":[]},"jK":{"M":[]}}'))
var y=(function rtii(){var x=C.a_
return{x:x("fG"),F:x("p<ap>"),y:x("p<cH>"),w:x("i"),g:x("iI"),f:x("fj<cH>"),b:x("@"),z:x("~()?"),v:x("~"),a:x("~(E)")}})();(function constants(){var x=a.makeConstList
B.oB=new A.vT()
B.ds=new A.fG(0,"up")
B.dt=new A.fG(1,"down")
B.du=new A.fG(2,"left")
B.aC=new A.fG(3,"right")
B.p_=new C.aL(15e4)
B.aF=new A.jK(0,"notStarted")
B.dE=new A.jK(1,"playing")
B.aG=new A.jK(2,"gameOver")
B.wc=new C.aJ("SNAKE",null)
B.qj=x([B.wc],y.F)
B.qD=x([],y.F)
B.wf=new C.aJ("Play Again",null)
B.qU=x([B.wf],y.F)
B.v6=new A.cH(10,10)
B.v7=new A.cH(8,10)
B.v8=new A.cH(9,10)
B.vF=new A.kr(null)
B.xj=new A.ym(null)
B.wg=new C.aJ("Press an arrow key to start.",null)
B.qI=x([B.wg],y.F)
B.xp=new F.ho("message",B.qI,null)
B.wa=new C.aJ("Or press R to restart.",null)
B.qH=x([B.wa],y.F)
B.xq=new F.ho("message",B.qH,null)})();(function lazyInitializers(){var x=a.lazyFinal
x($,"ZZ","Qv",()=>C.r(C.ci(),"HTMLAnchorElement",C.a_("bT")))})()};
(a=>{a["jW0po6+0+BdguGu/w1/xJgL/fVY="]=a.current})($__dart_deferred_initializers__);
//# sourceMappingURL=main.client.dart.js_1.part.js.map
