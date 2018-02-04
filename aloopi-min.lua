
local function R1FIoQI(dijn4Ph)local CO1={}for RlZo,SUn in next,dijn4Ph do CO1[RlZo]=SUn end;return CO1 end
local function NsoTwDs(Ib4)
local function fjV1G2(Do)local _={}for TqYJ4,DI in next,Do do
if type(DI)=='table'then _[TqYJ4]=NsoTwDs(DI)else _[TqYJ4]=DI end end;return _ end;return fjV1G2(Ib4)end
local function HGli(b,E)local KMw7_i1s=b or{}for CQi,nHlJ in next,E do
if type(b[CQi])=='nil'then KMw7_i1s[CQi]=nHlJ end end;return KMw7_i1s end
local function iy(lw4Q7kbl)local IN=0;for QYf1,RfsnisO in next,lw4Q7kbl do IN=IN+1 end;return IN end
local function m6SCS0(lvW2ga)for T7RKP,_L6Bs in next,lvW2ga do print(T7RKP,_L6Bs)end end
local function NUhYw6R4(SH)local wU4wYbA9={}
for fFeQcIM,JEHSHPh3 in next,SH do wU4wYbA9[JEHSHPh3]=JEHSHPh3 end;return wU4wYbA9 end
local function Hv(bb,o5e6fP,iq7ol)local eMV={}local WDTNkTD=1
for Oejsws=o5e6fP,iq7ol do eMV[WDTNkTD]=bb[Oejsws]WDTNkTD=WDTNkTD+1 end;return eMV end;local function Ch(CkD73N0)
if CkD73N0 then if CkD73N0:match('^[a-zA-Z_]$')then return true end end;return false end;local function urkh(PlwhaRKJ)if PlwhaRKJ then if
PlwhaRKJ:match('^[a-zA-Z_0-9]$')then return true end end;return
false end
local zhzpBSx=NUhYw6R4{'string','number','function','table','boolean','userdata','thread','nil','any'}local rHSjalVy={}
local function TjhsnP(Caz4NM4Z)local XVxxx=typeof and typeof or type
local hD=XVxxx(Caz4NM4Z)if hD=='table'then
if rawget(Caz4NM4Z,'__baseclass')==rHSjalVy then return true end end end
local function t5jzEd9(G5BuU5)local AfwsY=typeof and typeof or type;local T=AfwsY(G5BuU5)
if
T=='table'then if rawget(G5BuU5,'__baseclass')==rHSjalVy then
return rawget(G5BuU5,'__name')end end;return zhzpBSx[T]or T end
local function JZAU2(WZs,ITdz,AjfoUo)
if t5jzEd9(ITdz)=='table'then local Er9zidsB=iy(WZs.dimensions)
local function X(dR,JFXtQwy)
local uMV17h0=WZs.dimensions[JFXtQwy]
if uMV17h0 >0 then if iy(dR)~=uMV17h0 then
error('Array does not contain '..
(uMV17h0 >0 and uMV17h0 or'any')..' items')end end
for E2NZK,WNWWe in next,dR do if t5jzEd9(E2NZK)~='number'then
error('Element in dimension \''..
JFXtQwy..'\' does not have numerical keys.')end
if JFXtQwy<Er9zidsB then
if
t5jzEd9(WNWWe)=='table'then X(WNWWe,JFXtQwy+1)else
error('Expected item in dimension '..

tostring(Er9zidsB)..', got '..t5jzEd9(WNWWe)..' instead.')end else
for zMzjn3lk,WNWWe in next,dR do
if t5jzEd9(WNWWe)~=WZs.val_dt then
if
t5jzEd9(WNWWe)=='nil'and WZs.val_optional then else
error('Element in dimension \''..
JFXtQwy..'\' at index \''..zMzjn3lk..
'\' is not of datatype \''..WZs.val_dt..'\'')end end end end end end;X(ITdz,1)else
error('Got: \''..
t5jzEd9(ITdz)..'\' instead of an array of \''..WZs.dt..
'\' in \''..AjfoUo..'\'')end end
local function zPXTTg(Trkkpmd,L,GGv)local ZIzh4Si=Trkkpmd.ct;local c8D4n81=Trkkpmd.key_dt;local cSjJHx=Trkkpmd.key_optional
local fa=Trkkpmd.val_dt;local M=Trkkpmd.val_optional
if t5jzEd9(L)=='table'then
for dIZlrvD,jQgsATKd in next,L do
if
t5jzEd9(dIZlrvD)~=c8D4n81 then
if t5jzEd9(dIZlrvD)=='nil'and M then else
error('Keys\' datatype is \''..
t5jzEd9(dIZlrvD)..
'\', not datatype \''..c8D4n81 ..'\' in \''..GGv..'\'')end end
if t5jzEd9(jQgsATKd)~=fa then
if t5jzEd9(jQgsATKd)=='nil'and M then else
error(
'Values\' datatype is \''..t5jzEd9(dIZlrvD)..
'\', not datatype \''..c8D4n81 ..'\' in \''..GGv..'\'')end end end else
error('Got: \''..t5jzEd9(L)..
'\' instead of a dictionary of \''..c8D4n81 ..'\' to \''..fa..
'\' in \''..Trkkpmd.raw_key..'\'')end end
local function seMLr(aBbGg,D9,G)local gE=aBbGg.ct;local QgC=aBbGg.dt;local CYoa=t5jzEd9(D9)
if CYoa==QgC then
if gE=='array'then
JZAU2(aBbGg,D9,G)elseif gE=='dictionary'then zPXTTg(aBbGg,D9,G)end elseif CYoa=='nil'and aBbGg.optional then elseif QgC=='any'then else
error('Got: \''..CYoa..'\' instead of \''..QgC..
'\' in \''..G..'\'')end end
local function qX(K3ipRr,F2tY,rb21L2)for o_v255,wUVm in next,F2tY do seMLr(K3ipRr,wUVm,rb21L2)end end
local function h_8(VQ,oTYNsnP,I)
if oTYNsnP.ct=='fn'then
return
function(...)local L={...}
if#L>0 then
if VQ then if L[1]==VQ then L=Hv(L,2,#L)end end
if oTYNsnP.params then
for mR5gwW,DfbW in next,oTYNsnP.params do
if DfbW.vargs==true then
qX(DfbW,Hv(L,mR5gwW,#L),oTYNsnP.raw_key)break else seMLr(DfbW,L[mR5gwW],oTYNsnP.raw_key)end end end end;return I(oTYNsnP,L)end end;return oTYNsnP.val end
local function xL7OTb(sh,rrFLbCtj)
if not sh.const then if sh.ct~=''then seMLr(sh,rrFLbCtj)end
sh.val=rrFLbCtj else error('Cannot change value of a constant!')end;return sh end;local function w8T3f(YcPea0vg)
if(YcPea0vg:sub(1,1)=='_')then return'private'else return'public'end end
local function K(usLpLoaH)return
usLpLoaH:find(':')or
usLpLoaH:find('%(')or usLpLoaH:sub(1,6)=='const 'end;local qL;local vfIyB
do
local e7dv=NUhYw6R4{'(',')','[',']',',',':','<','>','.','?'}local inx0=NUhYw6R4{'const'}
local function A5k5yt(EEpoeR)local _k=1;local Ef={}
local KfM=EEpoeR:sub(_k,_k)
while _k<=EEpoeR:len()do
if not e7dv[KfM]then
if Ch(KfM)then local Vd=KfM
local Oynw=EEpoeR:sub(_k+1,_k+1)
if Oynw then if urkh(Oynw)then _k=_k+1;KfM=EEpoeR:sub(_k,_k)while urkh(KfM)do Vd=Vd..KfM
_k=_k+1;KfM=EEpoeR:sub(_k,_k)end else _k=_k+1
KfM=EEpoeR:sub(_k,_k)end end;if inx0[Vd]then Ef[#Ef+1]={type=Vd,lexme=Vd}else
Ef[#Ef+1]={type='ID',lexme=Vd}end elseif tonumber(KfM)then local QBO=KfM
local s4ggux=EEpoeR:sub(_k+1,_k+1)
if s4ggux then
if tonumber(s4ggux)then _k=_k+1;KfM=EEpoeR:sub(_k,_k)while tonumber(KfM)do
QBO=QBO..KfM;_k=_k+1;KfM=EEpoeR:sub(_k,_k)end else
_k=_k+1;KfM=EEpoeR:sub(_k,_k)end end;Ef[#Ef+1]={type='NUMBER',lexme=QBO}elseif KfM:match('^[ \t\n]$')then
_k=_k+1;KfM=EEpoeR:sub(_k,_k)end elseif e7dv[KfM]then Ef[#Ef+1]={type=KfM,lexme=KfM}_k=_k+1
KfM=EEpoeR:sub(_k,_k)else
error('Unknown character \''..KfM..'\'.')end end;return Ef end
local B7SHDx7h={['str']='string',['num']='number',['fn']='function',['tab']='table',['bool']='boolean',['usd']='userdata',['thr']='thread'}
do local hrVI4meU=0;local xEq6TAF={}local UIjls;local jdLnB0vD=''local PSlD=''local nN;local function J(I5)if UIjls then
if UIjls.type==I5 then return true end end end
local function A(JmE)
if
UIjls.type==JmE then local s4=UIjls;if hrVI4meU+1 <=#xEq6TAF then hrVI4meU=hrVI4meU+1
UIjls=xEq6TAF[hrVI4meU]end;return s4 else
error('Got \''..
UIjls.type..'\' instead of \''..JmE..'\' in \''..
jdLnB0vD..'\'')end end;local function g3Qeqnr(FFG)
return zhzpBSx[FFG]or B7SHDx7h[FFG]or FFG end;local qHpY64
local function z(a31jEAS)a31jEAS.ct='array'
a31jEAS.dimensions={}A'['local LS4h=1;a31jEAS.dimensions[LS4h]=-1
while true do
if J'NUMBER'then
a31jEAS.dimensions[LS4h]=tonumber(A'NUMBER'.lexme)elseif J','then A','LS4h=LS4h+1;a31jEAS.dimensions[LS4h]=-1 elseif J']'then break else
error(
'Invalid array expression in \''..jdLnB0vD..'\'')break end end;A']'return a31jEAS end
local function qccJ5b(eux092_P)eux092_P.dt=g3Qeqnr(A'ID'.lexme)
if J'<'then A'<'local ZA9=qHpY64()
if J','then
A','eux092_P.ct='dictionary'eux092_P.key_dt=ZA9.dt
eux092_P.key_optional=ZA9.optional;local hWgmxm=qHpY64()eux092_P.val_dt=hWgmxm.dt
eux092_P.val_optional=hWgmxm.optional else eux092_P.ct='array'eux092_P.val_dt=ZA9.dt
eux092_P.dimensions[1]=-1 end;A'>'end;if J'?'then A'?'eux092_P.optional=true end;return eux092_P end
qHpY64=function(UBg54E)UBg54E=UBg54E or{ct='datatype',dt='any'}
if J'['then
UBg54E=z(UBg54E)local gQGq=qHpY64()UBg54E.val_dt=gQGq.dt
UBg54E.val_optional=gQGq.optional elseif J'ID'then
if g3Qeqnr(UIjls.lexme)=='table'then UBg54E=qccJ5b(UBg54E)else
local OyHc5FEv=g3Qeqnr(A'ID'.lexme)UBg54E.dt=OyHc5FEv;if J'?'then A'?'UBg54E.optional=true end end else
error('Expected a type_expression in \''..jdLnB0vD..'\'')end;return UBg54E end;local function ARuba()A':'nN=qHpY64(nN)nN.ct='var'end
local function Wo53nZ(Dn1Xi)
Dn1Xi=qHpY64(Dn1Xi)if J'.'then A'.'A'.'A'.'Dn1Xi.vargs=true end;return Dn1Xi end
local function XRfQ()A'('nN.ct='fn'nN.dt='function'nN.params={}
while not J')'do
if J'ID'or J'['then
local _gGmBBE=Wo53nZ()nN.params[#nN.params+1]=_gGmBBE
if _gGmBBE.vargs then break end;if J','then A','elseif J'ID'then
error('Was expecting \')\' not \''..UIjls.lexme..'\' in \''..jdLnB0vD)end elseif J','then A','nN.params[
#nN.params+1]={ct='datatype',dt='any'}elseif J'.'then A'.'A'.'
A'.'
nN.params[#nN.params+1]={ct='datatype',dt='any',vargs=true}break else
error('Found \''..
UIjls.lexme..'\' instead of \')\' in \''..jdLnB0vD)end end;A')'end
local function gFPRdEC()PSlD=A'ID'.lexme;if J':'then ARuba()elseif J'('then XRfQ()end end;local function lw9gLt3()A'const'gFPRdEC()nN.const=true end
local function T()if J'const'then
lw9gLt3()elseif J'ID'then gFPRdEC()end end
qL=function(rIX4,AI14eFhp)
if K(rIX4)then hrVI4meU=1;jdLnB0vD=rIX4;PSlD=rIX4
nN={ct='',dt='',raw_key=jdLnB0vD,val=AI14eFhp}xEq6TAF=A5k5yt(rIX4)UIjls=xEq6TAF[hrVI4meU]T()if not nN.const then
seMLr(nN,AI14eFhp)end;return PSlD,nN else local iW2O=t5jzEd9(AI14eFhp)
return rIX4,{ct=
iW2O=='function'and'fn'or'',dt=iW2O,raw_key=rIX4,val=AI14eFhp}end end end
vfIyB=function(Gdp)local nbqmx={}for IWQcC,cvRh in next,Gdp do local W9yaJm,oJ1ec;W9yaJm,oJ1ec=qL(IWQcC,cvRh)
nbqmx[W9yaJm]=oJ1ec end;return nbqmx end end;local quNsijN
do local L;local MMNWLk;local x6Ni
local function Q2waXkyp(mlTMZ)local q=mlTMZ:sub(1,1)if q==q:upper()then return MMNWLk else
return L end end
local function EG72(xb6,yK)
if xb6:sub(1,2)=='__'then x6Ni[xb6]=yK elseif xb6:sub(1,1)=='_'then
Q2waXkyp(xb6:sub(2)).private[xb6]=yK else Q2waXkyp(xb6).public[xb6]=yK end end
quNsijN=function(rHLz2GD)L={public={},private={}}MMNWLk={public={},private={}}x6Ni={}for BlW0RhJA,Uy in next,rHLz2GD do
EG72(BlW0RhJA,Uy)end;return L,MMNWLk,x6Ni end end;local function QUh2tc(n)return HGli(n.public,n.private)end
local function qboV(TKu,M6kL)
local M7o_=TKu.__static_members
local function dk2X7J7(E2OQ)if t5jzEd9(M7o_.public[E2OQ])~='nil'then
return M7o_.public[E2OQ]elseif t5jzEd9(M7o_.private[E2OQ])~='nil'then
return M7o_.private[E2OQ]end end
local function jv(SnbfLb6,ay)
if ay=='super'then
if M6kL then local W=M6kL.__get_static_member(ay)
if W~=nil then return
h_8(SnbfLb6,W,function(WzM,PSx)return
WzM.val(SnbfLb6,unpack(PSx))end)end;return W else
error('Class \''..class_type..'\' does not have a super class!')end else local I=dk2X7J7(ay)if I~=nil then
return h_8(SnbfLb6,I,function(wnA,cW)
return wnA.val(SnbfLb6,unpack(cW))end)end;return I end end
local function MW(PHpCof2,bUPpn4T2,sode)local G9zkKODk=dk2X7J7(bUPpn4T2)
if G9zkKODk~=nil then local MGt,ld9GuG4t
MGt,ld9GuG4t=qL(bUPpn4T2,sode)M7o_[w8T3f(MGt)][MGt]=ld9GuG4t end end;return setmetatable({},{__index=jv,__newindex=MW})end
local function nSBOx7(KpCCA,H6,hgsKvTz)local zEt=QUh2tc(NsoTwDs(KpCCA.__prototype))
return
setmetatable({__first_super=H6,__next_super=H6},{__index=function(Wjojpvg,l2PqbWw)
if
hgsKvTz[l2PqbWw]then return hgsKvTz[l2PqbWw](Wjojpvg,l2PqbWw,zEt)end;local EJTH9=zEt[l2PqbWw]
if EJTH9 ==nil then if KpCCA.__prototype[l2PqbWw]then
EJTH9=KpCCA.__prototype[l2PqbWw]else
EJTH9=Wjojpvg.__first_super.__get_instance_member(l2PqbWw)end end
if EJTH9 ~=nil then return
h_8(Wjojpvg,EJTH9,function(EJTH9,qTB82)return EJTH9.val(Wjojpvg,unpack(qTB82))end)end end,__newindex=function(KL,EATFLbgY,FF)
local rh=zEt[EATFLbgY]if rh==nil then new_key,new_val=qL(EATFLbgY,FF)zEt[new_key]=new_val else
zEt[EATFLbgY]=xL7OTb(rh,FF)end end}),zEt end
function create_instance(YcCR,G3p2Yn,_jkkD9)local D=YcCR.__super;local DMn=YcCR.__meta;local GBzFRjVV=YcCR.__members;local pG4C8fDK
local LLFUU;local kdmQtj6=false
pG4C8fDK,LLFUU=nSBOx7(YcCR,D,{['super']=function(Hc35_,ubP,LLFUU)
if not kdmQtj6 then
return
function(...)
if Hc35_.__next_super then local eN0UMW={...}if
eN0UMW[1]==Hc35_ then eN0UMW=Hv(eN0UMW,2,#eN0UMW)end
Hc35_.__next_super.__prototype_self(Hc35_,eN0UMW)kdmQtj6=true else
error('Class \''..YcCR.__name..'\' does not have a super class!')end end else local lAG=D.__get_instance_member(ubP)
if t5jzEd9(lAG)~='nil'then return
h_8(Hc35_,lAG,function(lAG,AvEtR8Y)return
lAG.val(Hc35_,unpack(AvEtR8Y))end)end;return lAG end end})
assert(DMn.__init~=nil,'\'__init\' does not exist in class \''..YcCR.__name..'\'')
h_8(YcCR,DMn.__init,function(rl3MMqfm,nQj)rl3MMqfm.val(pG4C8fDK,unpack(nQj))end)(unpack(G3p2Yn))do local Eq8jDq={}for LnQUN,Gm1 in next,DMn do Eq8jDq[LnQUN]=Gm1.val end
DMn=Eq8jDq end
return
setmetatable({__baseclass=YcCR.__baseclass,__hierarchy=YcCR.__hierarchy,__name=YcCR.__name},HGli({__index=function(Jp,NwBqNl3C)
if
NwBqNl3C:sub(1,1)~='_'then obj=LLFUU[NwBqNl3C]if t5jzEd9(obj)=='nil'and D then
obj=D.__get_instance_member(NwBqNl3C)end
if t5jzEd9(obj)~='nil'then return
h_8(Jp,obj,function(XuqjvYPF,Trh)return
XuqjvYPF.val(pG4C8fDK,unpack(Trh))end)end end end,__newindex=function(KuK,s0FU,wQl)
if
s0FU:sub(1,1)~='_'then local g=LLFUU[s0FU]
if g==nil then new_key,new_val=qL(s0FU,wQl)
LLFUU[new_key]=new_val else LLFUU[s0FU]=xL7OTb(g,wQl)end else error('Cannot set a private value!')end end,__tostring=function(m4u)
if
t5jzEd9(DMn.__tostring)=='function'then return DMn.__tostring(pG4C8fDK)end;return"instance '"..m4u.__name.."'"end},DMn))end
local function u(StZ,C1NqzxY,T1gVrYq)StZ=StZ or''C1NqzxY=vfIyB(C1NqzxY)
local P5G=StZ~=''and StZ or'<anonymous>'if T1gVrYq then
P5G=rawget(T1gVrYq,'__hierarchy')..'.'..P5G end;C1NqzxY.__index=nil
C1NqzxY.__newindex=nil
return{__baseclass=rHSjalVy,__hierarchy=P5G,__name=StZ,__super=T1gVrYq,__members=C1NqzxY}end
local function Ki1(JC,PDA,Kqne5Stra)local FKLmmhnQ=u(JC,PDA,Kqne5Stra)local F82;local wJ6tY_;local TNg
F82,wJ6tY_,TNg=quNsijN(FKLmmhnQ.__members)FKLmmhnQ.__baseclass=rHSjalVy;FKLmmhnQ.__meta=TNg
FKLmmhnQ.__static_members=wJ6tY_;FKLmmhnQ.__prototype=F82
FKLmmhnQ.__get_static_member=function(QMcSUqdi)
if
(
t5jzEd9(wJ6tY_.public[QMcSUqdi])=='nil'and
t5jzEd9(wJ6tY_.private[QMcSUqdi])=='nil')and Kqne5Stra then return
Kqne5Stra.__get_static_member(QMcSUqdi)end;return
wJ6tY_.public[QMcSUqdi]or wJ6tY_.private[QMcSUqdi]end
FKLmmhnQ.__get_instance_member=function(sKy2P9i)
if
(
t5jzEd9(F82.public[sKy2P9i])=='nil'and t5jzEd9(F82.private[sKy2P9i])=='nil')and Kqne5Stra then return
Kqne5Stra.__get_instance_member(sKy2P9i)end
return F82.public[sKy2P9i]or F82.private[sKy2P9i]end
FKLmmhnQ.__prototype_self=function(S,AD)S.__next_super=Kqne5Stra
assert(TNg.__init~=nil,
'\'__init\' does not exist in class \''..FKLmmhnQ.__name..'\'')
h_8(nil,TNg.__init,function(AkxLdb66,aUR)AkxLdb66.val(S,unpack(aUR))end)(unpack(AD))end;local wO9T=qboV(FKLmmhnQ,Kqne5Stra)
return
setmetatable(FKLmmhnQ,{__index=function(FKLmmhnQ,c4)
local ZNXs3Bwd=wJ6tY_.public[c4]
if ZNXs3Bwd~=nil then return
h_8(FKLmmhnQ,ZNXs3Bwd,function(Ginn,h_pK)return Ginn.val(wO9T,unpack(h_pK))end)elseif Kqne5Stra then return Kqne5Stra[c4]end;return ZNXs3Bwd end,__newindex=function(FKLmmhnQ,L,vBKFXR3)
wJ6tY_.public[L]=xL7OTb(wJ6tY_.public[L],vBKFXR3)end,__call=function(...)local FP3j={...}
FP3j=Hv(FP3j,2,#FP3j)return create_instance(FKLmmhnQ,{...})end,__tostring=function(fe)return
"complex class '"..JC.."'"end})end
local function zz1QI(ggnA,KaD2ExEO)local TpiFT=u(ggnA,KaD2ExEO)if not TpiFT.__meta.__init then
error(
'__init is not defined in class \''..TpiFT.__name..'\'')end;return
setmetatable(TpiFT,{__call=function(...)local J={...}
J=Hv(J,2,#J)return create_instance(TpiFT,{...})end})end;local function kFTAh()end;local LBf={}LBf.typeof=t5jzEd9;LBf.is_a_class=TjhsnP
function LBf.class(CH)
assert(
t5jzEd9(CH)=='string','Class name must be a string!')return
function(sJ05I)return
function(HrLCim)
assert(t5jzEd9(HrLCim)=='table','Class must have a members table!')return Ki1(CH,HrLCim,sJ05I)end end end
function LBf.instanceof(w,sUu7z)local M5oB=rawget(w,'__hierarchy')local xIyIKo={}local f2x=""for Nwl in
string.gmatch(M5oB,'.')do
if(Nwl~='.')then f2x=f2x..Nwl else if f2x==sUu7z then return true end end end
if f2x==sUu7z then return true end;return false end;function LBf.mixin(Xpt_SQ,Y)end;return LBf