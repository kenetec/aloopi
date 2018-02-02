
local function iD1IUx(nSBOx7)local u={}for Ki1,zz1QI in next,nSBOx7 do u[Ki1]=zz1QI end;return u end
local function JLCOx_ak(kFTAh)
local function LBf(dijn4Ph)local CO1={}
for RlZo,SUn in next,dijn4Ph do if type(SUn)=='table'then CO1[RlZo]=JLCOx_ak(SUn)else
CO1[RlZo]=SUn end end;return CO1 end;return LBf(kFTAh)end
local function hPQ(Ib4,fjV1G2)local Do=Ib4 or{}for _,TqYJ4 in next,fjV1G2 do Do[_]=TqYJ4 end;return Do end
local function R1FIoQI(DI,b)local E=DI or{}for KMw7_i1s,CQi in next,b do
if type(DI[KMw7_i1s])=='nil'then E[KMw7_i1s]=CQi end end;return E end
local function NsoTwDs(nHlJ)local lw4Q7kbl=0;for IN,QYf1 in next,nHlJ do lw4Q7kbl=lw4Q7kbl+1 end;return lw4Q7kbl end
local function HGli(RfsnisO)for lvW2ga,T7RKP in next,RfsnisO do print(lvW2ga,T7RKP)end end
local function iy(_L6Bs)local SH={}for wU4wYbA9,fFeQcIM in next,_L6Bs do SH[fFeQcIM]=fFeQcIM end;return SH end
local function m6SCS0(JEHSHPh3,bb,o5e6fP)local iq7ol={}local eMV=1
for WDTNkTD=bb,o5e6fP do iq7ol[eMV]=JEHSHPh3[WDTNkTD]eMV=eMV+1 end;return iq7ol end;local function NUhYw6R4(Oejsws)
if Oejsws then if Oejsws:match('^[a-zA-Z_]$')then return true end end;return false end;local function Hv(CkD73N0)if CkD73N0 then if
CkD73N0:match('^[a-zA-Z_0-9]$')then return true end end
return false end;local function Ch(PlwhaRKJ)if PlwhaRKJ then if
PlwhaRKJ:match('^[ \t\n]$')then return true end end
return false end
local urkh=iy{'string','number','function','table','boolean','userdata','thread','nil','any'}
local function zhzpBSx(Caz4NM4Z)local XVxxx=typeof and typeof or type;local hD=XVxxx(Caz4NM4Z)
if hD==
'table'then
local G5BuU5,AfwsY=pcall(function()return getmetatable(Caz4NM4Z)end)
if G5BuU5 then if XVxxx(AfwsY)=='table'then
if AfwsY.__type then return AfwsY.__type end end end end;return urkh[hD]or hD end
local rHSjalVy={mt={__type='Container'},base={type='',dt='any',val=nil,raw_key=''}}function rHSjalVy.new()
return setmetatable(rHSjalVy.base,rHSjalVy.mt)end;function rHSjalVy.copy(T)local WZs=iD1IUx(T)return
setmetatable(WZs,rHSjalVy.mt)end
function rHSjalVy.fn(ITdz)return
setmetatable(R1FIoQI({type='fn',dt='function',params={}},
ITdz and ITdz or rHSjalVy.base),rHSjalVy.mt)end
function rHSjalVy.var(AjfoUo)return
setmetatable(R1FIoQI({type='var'},AjfoUo and AjfoUo or rHSjalVy.base),rHSjalVy.mt)end
function rHSjalVy.datatype(Er9zidsB)return
setmetatable(R1FIoQI({type='datatype'},Er9zidsB and Er9zidsB or rHSjalVy.base),rHSjalVy.mt)end
function rHSjalVy.array(X)return
setmetatable(R1FIoQI({type='array',dt='table',val_dt='',val_optional=false,dimensions={}},X and X or
rHSjalVy.base),rHSjalVy.mt)end
function rHSjalVy.dictionary(dR)
return
setmetatable(R1FIoQI({type='dictionary',dt='table',key_dt='',key_optional=false,val_dt='',val_optional=false},
dR and dR or rHSjalVy.base),rHSjalVy.mt)end
function rHSjalVy.vargs(JFXtQwy)return
setmetatable(R1FIoQI({vargs=true},JFXtQwy and JFXtQwy or rHSjalVy.base),rHSjalVy.mt)end
function rHSjalVy.const(uMV17h0)return
setmetatable(R1FIoQI({const=true},uMV17h0 and uMV17h0 or rHSjalVy.base),rHSjalVy.mt)end
function rHSjalVy.optional(E2NZK)return
setmetatable(R1FIoQI({optional=true},E2NZK and E2NZK or rHSjalVy.base),rHSjalVy.mt)end
local function TjhsnP(WNWWe,zMzjn3lk)
if zhzpBSx(zMzjn3lk)=='table'then
local Trkkpmd=NsoTwDs(WNWWe.dimensions)
local function L(GGv,ZIzh4Si)local c8D4n81=WNWWe.dimensions[ZIzh4Si]
if c8D4n81 >0 then if
NsoTwDs(GGv)~=c8D4n81 then
error('Array does not contain '.. (c8D4n81 >0 and c8D4n81 or'any')..
' items')end end
for cSjJHx,fa in next,GGv do if zhzpBSx(cSjJHx)~='number'then
error('Element in dimension \''..
ZIzh4Si..'\' does not have numerical keys.')end
if ZIzh4Si<Trkkpmd then if
zhzpBSx(fa)=='table'then L(fa,ZIzh4Si+1)else
error('Expected item in dimension '..tostring(Trkkpmd)..
', got '..zhzpBSx(fa)..' instead.')end else
for M,fa in next,GGv do
if
zhzpBSx(fa)~=WNWWe.val_dt then
if zhzpBSx(fa)=='nil'and WNWWe.val_optional then else
error(
'Element in dimension \''..ZIzh4Si..'\' at index \''..
M..'\' is not of datatype \''..WNWWe.val_dt..'\'')end end end end end end;L(zMzjn3lk,1)else
error('Got: \''..zhzpBSx(zMzjn3lk)..
'\' instead of an array of \''..WNWWe.dt..'\' in \''..
WNWWe.raw_key..'\'')end end
local function t5jzEd9(dIZlrvD,jQgsATKd)local aBbGg=dIZlrvD.type;local D9=dIZlrvD.key_dt;local G=dIZlrvD.key_optional
local gE=dIZlrvD.val_dt;local QgC=dIZlrvD.val_optional
if zhzpBSx(jQgsATKd)=='table'then
for CYoa,K3ipRr in next,jQgsATKd do
if
zhzpBSx(CYoa)~=D9 then
if zhzpBSx(CYoa)=='nil'and QgC then else
error('Keys\' datatype is \''..
zhzpBSx(CYoa)..'\', not datatype \''..
D9 ..'\' in \''..dIZlrvD.raw_key..'\'')end end
if zhzpBSx(K3ipRr)~=gE then
if zhzpBSx(K3ipRr)=='nil'and QgC then else
error(
'Values\' datatype is \''..zhzpBSx(CYoa)..'\', not datatype \''..
D9 ..'\' in \''..dIZlrvD.raw_key..'\'')end end end else
error('Got: \''..
zhzpBSx(jQgsATKd)..'\' instead of a dictionary of \''..
D9 ..'\' to \''..gE..'\' in \''..
dIZlrvD.raw_key..'\'')end end
local function JZAU2(F2tY,rb21L2)local o_v255=F2tY.type;local wUVm=F2tY.dt;local VQ=zhzpBSx(rb21L2)
if VQ==wUVm then
if
o_v255 =='array'then TjhsnP(F2tY,rb21L2)elseif o_v255 =='dictionary'then t5jzEd9(F2tY,rb21L2)end elseif VQ=='nil'and F2tY.optional then elseif wUVm=='any'then else
error('Got: \''..
VQ..'\' instead of \''..wUVm..'\' in \''..
F2tY.raw_key..'\'')end end
local function zPXTTg(oTYNsnP,I)for L,mR5gwW in next,I do JZAU2(oTYNsnP,mR5gwW)end end
local function seMLr(DfbW,sh,rrFLbCtj)
if zhzpBSx(sh.val)=='function'then
return
function(...)local YcPea0vg={...}
if#YcPea0vg>0 then if DfbW then
if YcPea0vg[1]==
DfbW then YcPea0vg=m6SCS0(YcPea0vg,2,#YcPea0vg)end end
if sh.type=='fn'then
for usLpLoaH,e7dv in next,sh.params do
if
e7dv.vargs==true then
zPXTTg(e7dv,m6SCS0(YcPea0vg,usLpLoaH,#YcPea0vg))break else JZAU2(e7dv,YcPea0vg[usLpLoaH])end end end end;return rrFLbCtj(sh,YcPea0vg)end end;return sh.val end
local function qX(inx0,A5k5yt)local B7SHDx7h=rHSjalVy.copy(inx0)
if inx0.const then
error('Cannot change value of a constant!')else JZAU2(inx0,A5k5yt)B7SHDx7h.val=A5k5yt end;return B7SHDx7h end;local function h_8(EEpoeR)
if zhzpBSx(EEpoeR)=='Container'then return EEpoeR.val end;return EEpoeR end
local function xL7OTb(_k)if
(_k:sub(1,1)=='_')then return'private'else return'public'end end;local w8T3f;local K
do
local Ef=iy{'(',')','[',']',',',':','<','>','.','?'}local KfM=iy{'const'}local Vd={}
function Vd.new(s4ggux,hrVI4meU,xEq6TAF)
return
setmetatable({type=s4ggux,lexme=hrVI4meU,literal=xEq6TAF},{__tostring=function(UIjls)return
UIjls.type..
'\t'..UIjls.lexme..'\t'..tostring(xEq6TAF)end})end;local Oynw
do local jdLnB0vD=0;local PSlD={}local nN={}
local function J()if jdLnB0vD+1 <=#PSlD then jdLnB0vD=jdLnB0vD+1;return
PSlD[jdLnB0vD]end end;local function A()
if jdLnB0vD+1 <=#PSlD then return PSlD[jdLnB0vD+1]end end;local function g3Qeqnr(qHpY64,z,qccJ5b)
nN[#nN+1]=Vd.new(qHpY64,z,qccJ5b)end
Oynw=function(ARuba)jdLnB0vD=0;PSlD={}nN={}for XRfQ in
ARuba:gmatch('.')do PSlD[#PSlD+1]=XRfQ end;local Wo53nZ=J()
while Wo53nZ~=nil do
if not
Ef[Wo53nZ]then
if NUhYw6R4(Wo53nZ)then local gFPRdEC=Wo53nZ;if A()then
if Hv(A())then Wo53nZ=J()while Hv(Wo53nZ)do
gFPRdEC=gFPRdEC..Wo53nZ;Wo53nZ=J()end else Wo53nZ=J()end end;if KfM[gFPRdEC]then
g3Qeqnr(gFPRdEC,gFPRdEC)else g3Qeqnr('ID',gFPRdEC)end elseif
tonumber(Wo53nZ)then local lw9gLt3=Wo53nZ;if A()then
if tonumber(A())then Wo53nZ=J()while tonumber(Wo53nZ)do
lw9gLt3=lw9gLt3 ..Wo53nZ;Wo53nZ=J()end else Wo53nZ=J()end end
g3Qeqnr('NUMBER',lw9gLt3,tonumber(lw9gLt3))elseif Ch(Wo53nZ)then Wo53nZ=J()end elseif Ef[Wo53nZ]then g3Qeqnr(Wo53nZ,Wo53nZ)Wo53nZ=J()else error('Unknown character \''..
Wo53nZ..'\'.')end end;return nN end end
local QBO={['str']='string',['num']='number',['fn']='function',['tab']='table',['bool']='boolean',['usd']='userdata',['thr']='thread'}
do local T=0;local I5={}local JmE;local s4=''local FFG=''local a31jEAS;local function LS4h()
if T+1 <=#I5 then T=T+1;return I5[T]end end;local function eux092_P(IWQcC)if JmE then
if JmE.type==IWQcC then return true end end end
local function ZA9(cvRh)if
JmE.type==cvRh then local W9yaJm=JmE;JmE=LS4h()return W9yaJm else
error('Got \''..
JmE.type..'\' instead of \''..cvRh..'\' in \''..
s4 ..'\'')end end
local function hWgmxm(oJ1ec)if urkh[oJ1ec]or QBO[oJ1ec]then
return urkh[oJ1ec]or QBO[oJ1ec]end;return oJ1ec end;local UBg54E
local function gQGq(L)L=rHSjalVy.datatype(L)
local MMNWLk=hWgmxm(ZA9'ID'.lexme)L.dt=MMNWLk
if eux092_P'?'then ZA9'?'L=rHSjalVy.optional(L)end;return L end
local function OyHc5FEv(x6Ni)x6Ni=rHSjalVy.array(x6Ni)x6Ni.raw_key=s4;ZA9'['local Q2waXkyp=1;x6Ni.dimensions[Q2waXkyp]=
-1
while true do
if eux092_P'NUMBER'then
x6Ni.dimensions[Q2waXkyp]=tonumber(ZA9'NUMBER'.lexme)elseif eux092_P','then ZA9','Q2waXkyp=Q2waXkyp+1
x6Ni.dimensions[Q2waXkyp]=-1 elseif eux092_P']'then break else
error('Invalid array expression in \''..s4 ..'\'')break end end;ZA9']'return x6Ni end
local function Dn1Xi(EG72)EG72.dt=hWgmxm(ZA9'ID'.lexme)
if eux092_P'<'then ZA9'<'
local mlTMZ=rHSjalVy.datatype()mlTMZ.raw_key=s4;mlTMZ=UBg54E(mlTMZ)
if eux092_P','then ZA9','
EG72=rHSjalVy.dictionary(EG72)EG72.key_dt=mlTMZ.dt;EG72.key_optional=mlTMZ.optional
local q=rHSjalVy.datatype()q.raw_key=s4;q=UBg54E(q)EG72.val_dt=q.dt;EG72.val_optional=q.optional else
EG72=rHSjalVy.array(EG72)EG72.dt=mlTMZ.dt;EG72.dimensions[1]=-1 end;ZA9'>'end
if eux092_P'?'then ZA9'?'EG72=rHSjalVy.optional(EG72)end;return EG72 end
UBg54E=function(xb6)
if eux092_P'['then xb6=OyHc5FEv(xb6)local yK=UBg54E(xb6)xb6.val_dt=yK.dt
xb6.val_optional=yK.optional elseif eux092_P'ID'then if hWgmxm(JmE.lexme)=='table'then xb6=Dn1Xi(xb6)else
xb6=gQGq(xb6)end else
error('Expected a type_expression in \''..xb6.raw_key..'\'')end;return xb6 end;local function _gGmBBE()ZA9':'a31jEAS=UBg54E(a31jEAS)
a31jEAS=rHSjalVy.var(a31jEAS)end
local function rIX4(rHLz2GD)rHLz2GD=UBg54E(rHLz2GD)
if
eux092_P'.'then ZA9'.'ZA9'.'ZA9'.'rHLz2GD=rHSjalVy.vargs(rHLz2GD)end;return rHLz2GD end
local function AI14eFhp()ZA9'('a31jEAS=rHSjalVy.fn(a31jEAS)
while not eux092_P')'do
if eux092_P'ID'or
eux092_P'['then local gQGq=rHSjalVy.datatype()gQGq.raw_key=s4
local BlW0RhJA=rIX4(gQGq)
a31jEAS.params[#a31jEAS.params+1]=BlW0RhJA
if BlW0RhJA.vargs then if eux092_P')'then break else
error('Cannot have additional parameters after a variable argument declaration in \''..s4 ..'\'')end end;if eux092_P','then ZA9','elseif eux092_P'ID'then
error('Was expecting \')\' not \''..JmE.lexme..'\' in \''..s4)end elseif eux092_P','then ZA9','
local Uy=rHSjalVy.datatype()Uy.raw_key=s4;Uy.dt='any'
a31jEAS.params[#a31jEAS.params+1]=Uy elseif eux092_P'.'then local n=rHSjalVy.datatype()n.raw_key=s4;ZA9'.'ZA9'.'
ZA9'.'n=rHSjalVy.vargs(n)
a31jEAS.params[#a31jEAS.params+1]=n;break else
error('Found \''..JmE.lexme..'\' instead of \')\' in \''..s4)end end;ZA9')'end;local function iW2O()FFG=ZA9'ID'.lexme
if eux092_P':'then _gGmBBE()elseif eux092_P'('then AI14eFhp()end end;local function Gdp()ZA9'const'iW2O()
a31jEAS=rHSjalVy.const(a31jEAS)end;local function nbqmx()
if eux092_P'const'then Gdp()elseif eux092_P'ID'then iW2O()end end
w8T3f=function(TKu,M6kL)
if
TKu:find(':')or TKu:find('%(')or TKu:sub(1,6)=='const 'then T=0;s4=TKu;FFG=TKu
a31jEAS=rHSjalVy.new()a31jEAS.raw_key=s4;a31jEAS.key=TKu;I5=Oynw(TKu)JmE=LS4h()if JmE then
nbqmx()end;JZAU2(a31jEAS,M6kL)a31jEAS.val=M6kL;return FFG,a31jEAS else
return TKu,M6kL end end end
K=function(M7o_)local dk2X7J7={}for jv,MW in next,M7o_ do new_key,new_val=w8T3f(jv,MW)
dk2X7J7[new_key]=new_val end;return dk2X7J7 end end;local qL
do local E2OQ;local SnbfLb6;local ay;local function W(PSx)local I=PSx:sub(1,1)
if I==I:upper()then return SnbfLb6 else return E2OQ end end
local function WzM(wnA,cW)
if wnA:sub(1,2)=='__'then
ay[wnA]=cW elseif wnA:sub(1,1)=='_'then
W(wnA:sub(2)).private[wnA]=cW else W(wnA).public[wnA]=cW end end
qL=function(PHpCof2)E2OQ={public={},private={}}SnbfLb6={public={},private={}}ay={}for bUPpn4T2,sode in next,PHpCof2 do
WzM(bUPpn4T2,sode)end;return E2OQ,SnbfLb6,ay end end
local function vfIyB(G9zkKODk)return R1FIoQI(G9zkKODk.public,G9zkKODk.private)end;local quNsijN={}
function quNsijN.new(MGt,ld9GuG4t,KpCCA)local H6=rawget(MGt,'_hierarchy')
local hgsKvTz=rawget(MGt,'_type')local zEt=rawget(MGt,'_meta')
local Wjojpvg=rawget(MGt,'_instance_members')local l2PqbWw=rawget(MGt,'_super')local EJTH9=vfIyB(Wjojpvg)local qTB82;local KL={}
local EATFLbgY=false
if KpCCA then
rawset(KpCCA,'_members',R1FIoQI(rawget(KpCCA,'_members'),EJTH9))rawset(KpCCA,'_next_super',l2PqbWw)
if zhzpBSx(zEt.__init)==
'Container'then
seMLr(nil,zEt.__init,function(G3p2Yn,_jkkD9)
G3p2Yn.val(KpCCA,unpack(_jkkD9))end)(unpack(ld9GuG4t))else zEt.__init(KpCCA,unpack(ld9GuG4t))end;EATFLbgY=true;return end
local function FF(D)if zhzpBSx(EJTH9[D])~='nil'then return EJTH9[D]elseif
zhzpBSx(KL[D])~='nil'then return KL[D]end end
local function rh(DMn,GBzFRjVV)
if GBzFRjVV~='super'then local pG4C8fDK=FF(GBzFRjVV)local LLFUU=zhzpBSx(pG4C8fDK)
if LLFUU==
'Container'then return
seMLr(DMn,pG4C8fDK,function(kdmQtj6,Hc35_)return kdmQtj6.val(DMn,unpack(Hc35_))end)elseif LLFUU=='function'then
return function(...)local ubP={...}if
ubP[1]==DMn then ubP=m6SCS0(ubP,2,#ubP)end;return
pG4C8fDK(DMn,unpack(ubP))end end;return pG4C8fDK else
return
function(...)
if rawget(DMn,'_next_super')then
if not EATFLbgY then local eN0UMW={...}if
eN0UMW[1]==qTB82 then eN0UMW=m6SCS0(eN0UMW,2,#eN0UMW)end
quNsijN.new(rawget(DMn,'_next_super'),eN0UMW,DMn)EATFLbgY=true else print'index super'end else
error('Class \''..hgsKvTz..'\' does not have a super class!')end end end end
local function YcCR(lAG,AvEtR8Y,rl3MMqfm)local nQj=FF(AvEtR8Y)
if zhzpBSx(nQj)~='Container'then
new_key,new_val=w8T3f(AvEtR8Y,rl3MMqfm)KL[new_key]=new_val else KL[AvEtR8Y]=qX(nQj,rl3MMqfm)end end
qTB82=setmetatable({_next_super=l2PqbWw,_members=EJTH9},{__index=rh,__newindex=YcCR})
if zhzpBSx(zEt.__init)=='Container'then
seMLr(nil,zEt.__init,function(Eq8jDq,LnQUN)
Eq8jDq.val(qTB82,unpack(LnQUN))end)(unpack(ld9GuG4t))else zEt.__init(qTB82,unpack(ld9GuG4t))end
do local Gm1={}for Jp,NwBqNl3C in next,zEt do Gm1[Jp]=h_8(NwBqNl3C)end;zEt=Gm1 end
return
setmetatable({_hierarchy=rawget(MGt,'_hierarchy')},R1FIoQI({__type=hgsKvTz,__index=function(XuqjvYPF,Trh)local KuK;if
Trh:sub(1,1)~='_'then KuK=FF(Trh)end;local s0FU=zhzpBSx(KuK)
if s0FU=='Container'then
local wQl=seMLr(XuqjvYPF,KuK,function(g,m4u)return
g.val(qTB82,unpack(m4u))end)return wQl elseif s0FU=='function'then return
function(...)local StZ={...}if StZ[1]==XuqjvYPF then
StZ=m6SCS0(StZ,2,#StZ)end;return KuK(qTB82,unpack(StZ))end end;return KuK end,__newindex=function(C1NqzxY,T1gVrYq,P5G)
if
T1gVrYq:sub(1,1)~='_'then local JC=FF(T1gVrYq)if zhzpBSx(JC)=='Container'then
KL[T1gVrYq]=qX(JC,P5G)else KL[T1gVrYq]=P5G end else
error('Cannot set a private value!')end end,__tostring=function(PDA)
if
zhzpBSx(zEt.__tostring)=='function'then return zEt.__tostring(qTB82)end;return hgsKvTz end},zEt))end;local QUh2tc={}
function QUh2tc.new(Kqne5Stra,FKLmmhnQ)local F82=''if FKLmmhnQ then
F82=rawget(FKLmmhnQ,'_hierarchy')..'.'end;Kqne5Stra=K(Kqne5Stra)local wJ6tY_;local TNg;local wO9T
wJ6tY_,TNg,wO9T=qL(Kqne5Stra)
if not wO9T.__type then error('__type is not defined in class.')end
assert(zhzpBSx(wO9T.__type)=='string','__type is not a string.')local QMcSUqdi=wO9T.__type;F82=F82 ..QMcSUqdi;wO9T.__index=nil
wO9T.__newindex=nil;wO9T.__metatable=nil;local sKy2P9i
do
local function AkxLdb66(ZNXs3Bwd)
if
zhzpBSx(TNg.public[ZNXs3Bwd])~='nil'then return TNg.public[ZNXs3Bwd]elseif zhzpBSx(TNg.private[ZNXs3Bwd])~=
'nil'then return TNg.private[ZNXs3Bwd]end end
local function aUR(Ginn,h_pK)
if h_pK=='super'then
if FKLmmhnQ then
if zhzpBSx(FKLmmhnQ[h_pK])=='function'then
return function(...)
local L={...}if L[1]==Ginn then L=m6SCS0(L,2,#L)end;return
FKLmmhnQ[h_pK](Ginn,unpack(L))end end;return FKLmmhnQ[h_pK]else
error('Class \''..QMcSUqdi..'\' does not have a super class!')end else local vBKFXR3=AkxLdb66(h_pK)local FP3j=zhzpBSx(vBKFXR3)
if FP3j=='Container'then return
seMLr(Ginn,vBKFXR3,function(fe,ggnA)return
fe.val(Ginn,unpack(ggnA))end)elseif FP3j=='function'then return
function(...)local KaD2ExEO={...}
if
KaD2ExEO[1]==Ginn then KaD2ExEO=m6SCS0(KaD2ExEO,2,#KaD2ExEO)end;return vBKFXR3(Ginn,unpack(KaD2ExEO))end end;return vBKFXR3 end end
local function c4(TpiFT,J,CH)local sJ05I=AkxLdb66(J)if zhzpBSx(sJ05I)~='Container'then local HrLCim,w
HrLCim,w=w8T3f(J,CH)TNg[xL7OTb(HrLCim)][HrLCim]=w else
TNg[xL7OTb(J)][J]=qX(sJ05I,CH)end end
sKy2P9i=function()return setmetatable({},{__index=aUR,__newindex=c4})end end;local S=sKy2P9i()
local AD=setmetatable({_super=FKLmmhnQ,_hierarchy=F82,_type=QMcSUqdi,_instance_members=wJ6tY_,_static_members=TNg,_meta=wO9T},{__type=type,__index=function(sUu7z,M5oB)
local xIyIKo=sUu7z._static_members.public[M5oB]local f2x=zhzpBSx(xIyIKo)
if f2x=='Container'then
local Nwl=seMLr(sUu7z,xIyIKo,function(Xpt_SQ,Y)return
Xpt_SQ.val(S,unpack(Y))end)
if zhzpBSx(Nwl)=='nil'and FKLmmhnQ then return FKLmmhnQ[M5oB]end;return Nwl elseif f2x=='function'then return
function(...)local SMa={...}if SMa[1]==sUu7z then
SMa=m6SCS0(SMa,2,#SMa)end;return xIyIKo(S,unpack(SMa))end end;return xIyIKo end,__newindex=function(Bo,zF6ZPjQ,nNQG3)
local yW=zhzpBSx(Bo._static_members.public[zF6ZPjQ])
if yW=='Container'then
Bo._static_members.public[zF6ZPjQ]=qX(Bo._static_members.public[zF6ZPjQ],nNQG3)else Bo._static_members.public[zF6ZPjQ]=nNQG3 end end,__call=function(efGM8UMy,...)if
not wO9T.__init then
error('__init is not defined in class \''..QMcSUqdi..'\'')end
return quNsijN.new(efGM8UMy,{...})end})return AD end;local qboV={}qboV.typeof=zhzpBSx;function qboV.class(KhH)return
function(H4tXd)return QUh2tc.new(H4tXd,KhH)end end;function qboV.instanceof(Nq6If,II)
end;return qboV