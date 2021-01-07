Shader "Hidden/GlobalFog" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "black" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  GpuProgramID 39986
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform mat4 _FrustumCornersWS;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec4 tmpvar_2;
  tmpvar_2.xyw = gl_Vertex.xyw;
  vec4 tmpvar_3;
  tmpvar_2.z = 0.1;
  int i_4;
  i_4 = int(gl_Vertex.z);
  vec4 v_5;
  v_5.x = _FrustumCornersWS[0][i_4];
  v_5.y = _FrustumCornersWS[1][i_4];
  v_5.z = _FrustumCornersWS[2][i_4];
  v_5.w = _FrustumCornersWS[3][i_4];
  tmpvar_3.xyz = v_5.xyz;
  tmpvar_3.w = gl_Vertex.z;
  gl_Position = (gl_ModelViewProjectionMatrix * tmpvar_2);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform float _GlobalDensity;
uniform vec4 _FogColor;
uniform vec4 _StartDistance;
uniform vec4 _Y;
uniform vec4 _CameraWS;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = ((1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x)
   + _ZBufferParams.y))) * xlv_TEXCOORD2);
  float tmpvar_2;
  tmpvar_2 = max (0.0, ((
    (_CameraWS + tmpvar_1)
  .y - _Y.x) * _Y.y));
  gl_FragData[0] = mix (texture2D (_MainTex, xlv_TEXCOORD0), _FogColor, vec4(((1.0 - 
    exp((-(_GlobalDensity) * (clamp (
      ((sqrt(dot (tmpvar_1.xyz, tmpvar_1.xyz)) * _StartDistance.x) - 1.0)
    , 0.0, 1.0) * _StartDistance.y)))
  ) * exp(
    -((tmpvar_2 * tmpvar_2))
  ))));
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 4 [_FrustumCornersWS]
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_MainTex_TexelSize]
"vs_2_0
def c9, 1, 0, 0.100000001, -2
dcl_position v0
dcl_texcoord v1
mad r0, v0.xyxw, c9.xxyx, c9.yyzy
dp4 oPos.x, c0, r0
dp4 oPos.y, c1, r0
dp4 oPos.z, c2, r0
dp4 oPos.w, c3, r0
mov r0.y, c9.y
slt r0.x, c8.y, r0.y
mad r0.y, v1.y, c9.w, c9.x
mad oT0.y, r0.x, r0.y, v1.y
mov oT0.x, v1.x
mov oT1.xy, v1
slt r0.x, v0.z, -v0.z
frc r0.y, v0.z
add r0.z, -r0.y, v0.z
slt r0.y, -r0.y, r0.y
mad r0.x, r0.x, r0.y, r0.z
mova a0.x, r0.x
mov oT2.xyz, c4[a0.x]
mov oT2.w, v0.z

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedemlifjfkfofplhlilgllkakpeiikmnbjabaaaaaaiiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadp
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaan
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdn
mnmmmmdnmnmmmmdnegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaa
aaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaa
abaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaaf
nccabaaaabaaaaaaagbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaa
aaaaaaaablaaaaafbcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaa
acaaaaaaegiocaaaaaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaaj
cccabaaaacaaaaaaegiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaa
bbaaaaajeccabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefieceddbondbkkkedkcfdmchhcmjmlhejnpfknabaaaaaanmafaaaaaeaaaaaa
daaaaaaaiaacaaaaaaafaaaafeafaaaaebgpgodjeiacaaaaeiacaaaaaaacpopp
aiacaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaakaa
aeaaagaaaaaaaaaaabaaaaaaaeaaakaaaaaaaaaaaaaaafaaaaacpoppfbaaaaaf
aeaaapkamnmmmmdnaaaaaamaaaaaiadpaaaaaaaafbaaaaafaaaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaafbaaaaafabaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaafbaaaaafacaaapkaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaafbaaaaaf
adaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaaciaagaaffkaamaaaaadaaaaabia
aaaaffiaaaaappkaaeaaaaaeaaaaaciaabaaffjaaeaaffkaaeaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaamaaaaadaaaaabiaaaaakkjaaaaakkjb
bdaaaaacaaaaaciaaaaakkjaacaaaaadaaaaaeiaaaaaffibaaaakkjaamaaaaad
aaaaaciaaaaaffibaaaaffiaaeaaaaaeaaaaabiaaaaaaaiaaaaaffiaaaaakkia
coaaaaacaaaaablaaaaaaaiaabaaaaadaaaaapiaaacaoekaaaaaaalaajaaaaad
abaaaboaahaaoekaaaaaoeiaajaaaaadabaaacoaaiaaoekaaaaaoeiaajaaaaad
abaaaeoaajaaoekaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaae
aaaaapiaakaaoekaaaaaaajaaaaaoeiaabaaaaacabaaabiaaeaaaakaaeaaaaae
aaaaapiaamaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaafaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaanoaabaabejaabaaaaacabaaaioaaaaakkjappppaaaa
fdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnmnmmmmdn
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaa
aaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafnccabaaaabaaaaaa
agbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaaaaaaaaaablaaaaaf
bcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaaacaaaaaaegiocaaa
aaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajcccabaaaacaaaaaa
egiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajeccabaaa
acaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaaaaaaaaaadoaaaaab
ejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
faepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 5 [_CameraWS]
Vector 2 [_FogColor]
Float 1 [_GlobalDensity]
Vector 3 [_StartDistance]
Vector 4 [_Y]
Vector 0 [_ZBufferParams]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_2_0
def c6, -1, 0, 1.44269502, 1
dcl t0.xy
dcl t1.xy
dcl t2.xyz
dcl_2d s0
dcl_2d s1
texld r0, t1, s1
texld r1, t0, s0
mad r0.x, c0.x, r0.x, c0.y
rcp r0.x, r0.x
mul r2.xyz, r0.x, t2
mad r2.w, r0.x, t2.y, c5.y
add r2.w, r2.w, -c4.x
mul r2.w, r2.w, c4.y
max r0.x, r2.w, c6.y
mul r2.w, r0.x, r0.x
mul r2.w, r2.w, -c6.z
exp r2.w, r2.w
dp3 r0.x, r2, r2
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r2.x, c6.x
mad_sat r0.x, r0.x, c3.x, r2.x
mul r0.x, r0.x, c3.y
mul r0.x, r0.x, -c1.x
mul r0.x, r0.x, c6.z
exp r0.x, r0.x
add r0.x, -r0.x, c6.w
mul r0.x, r2.w, r0.x
lrp_pp r2, r0.x, c2, r1
mov_pp oC0, r2

"
}
SubProgram "d3d11 " {
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 256
Float 96 [_GlobalDensity]
Vector 112 [_FogColor]
Vector 128 [_StartDistance]
Vector 144 [_Y]
Vector 240 [_CameraWS]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecednihgnbkcadhleakldegdglabgebidbkdabaaaaaagiaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchiadaaaaeaaaaaaanoaaaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaaakiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
diaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaaagbjbaaaacaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaa
apaaaaaaaaaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaajaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaa
aaaaaaaaajaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaadlkklilpbjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaa
aaaaaaaajgahbaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dccaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaialpdiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaaa
aaaaaaaaaiaaaaaadiaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaagaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaaj
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaa
dcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 256
Float 96 [_GlobalDensity]
Vector 112 [_FogColor]
Vector 128 [_StartDistance]
Vector 144 [_Y]
Vector 240 [_CameraWS]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefieceddcimlojfbnfbmfmainjmcdeomhjkgkfpabaaaaaakeagaaaaaeaaaaaa
daaaaaaagiacaaaaoiafaaaahaagaaaaebgpgodjdaacaaaadaacaaaaaaacpppp
oaabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaabaaaaaa
aaababaaaaaaagaaaeaaaaaaaaaaaaaaaaaaapaaabaaaeaaaaaaaaaaabaaahaa
abaaafaaaaaaaaaaaaacppppfbaaaaafagaaapkaaaaaialpaaaaaaaadlkklidp
aaaaiadpbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaacaaaaadiaaaaablla
ecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaadabaaapiaaaaaoelaaaaioeka
aeaaaaaeaaaaabiaafaaaakaaaaaaaiaafaaffkaagaaaaacaaaaabiaaaaaaaia
afaaaaadacaaahiaaaaaaaiaabaaoelaaeaaaaaeacaaaiiaaaaaaaiaabaaffla
aeaaffkaacaaaaadacaaaiiaacaappiaadaaaakbafaaaaadacaaaiiaacaappia
adaaffkaalaaaaadaaaaabiaacaappiaagaaffkaafaaaaadacaaaiiaaaaaaaia
aaaaaaiaafaaaaadacaaaiiaacaappiaagaakkkbaoaaaaacacaaaiiaacaappia
aiaaaaadaaaaabiaacaaoeiaacaaoeiaahaaaaacaaaaabiaaaaaaaiaagaaaaac
aaaaabiaaaaaaaiaabaaaaacacaaabiaagaaaakaaeaaaaaeaaaabbiaaaaaaaia
acaaaakaacaaaaiaafaaaaadaaaaabiaaaaaaaiaacaaffkaafaaaaadaaaaabia
aaaaaaiaaaaaaakbafaaaaadaaaaabiaaaaaaaiaagaakkkaaoaaaaacaaaaabia
aaaaaaiaacaaaaadaaaaabiaaaaaaaibagaappkaafaaaaadaaaaabiaacaappia
aaaaaaiabcaaaaaeacaacpiaaaaaaaiaabaaoekaabaaoeiaabaaaaacaaaicpia
acaaoeiappppaaaafdeieefchiadaaaaeaaaaaaanoaaaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaaakiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
diaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaaagbjbaaaacaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaa
apaaaaaaaaaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaajaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaa
aaaaaaaaajaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaadlkklilpbjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaa
aaaaaaaajgahbaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dccaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaialpdiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaaa
aaaaaaaaaiaaaaaadiaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaagaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaaj
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaa
dcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  GpuProgramID 84515
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform mat4 _FrustumCornersWS;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec4 tmpvar_2;
  tmpvar_2.xyw = gl_Vertex.xyw;
  vec4 tmpvar_3;
  tmpvar_2.z = 0.1;
  int i_4;
  i_4 = int(gl_Vertex.z);
  vec4 v_5;
  v_5.x = _FrustumCornersWS[0][i_4];
  v_5.y = _FrustumCornersWS[1][i_4];
  v_5.z = _FrustumCornersWS[2][i_4];
  v_5.w = _FrustumCornersWS[3][i_4];
  tmpvar_3.xyz = v_5.xyz;
  tmpvar_3.w = gl_Vertex.z;
  gl_Position = (gl_ModelViewProjectionMatrix * tmpvar_2);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _FogColor;
uniform vec4 _Y;
uniform vec4 _CameraWS;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  float tmpvar_1;
  tmpvar_1 = max (0.0, ((
    (_CameraWS + ((1.0/((
      (_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x)
     + _ZBufferParams.y))) * xlv_TEXCOORD2))
  .y - _Y.x) * _Y.y));
  gl_FragData[0] = mix (texture2D (_MainTex, xlv_TEXCOORD0), _FogColor, vec4(exp(-(
    (tmpvar_1 * tmpvar_1)
  ))));
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 4 [_FrustumCornersWS]
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_MainTex_TexelSize]
"vs_2_0
def c9, 1, 0, 0.100000001, -2
dcl_position v0
dcl_texcoord v1
mad r0, v0.xyxw, c9.xxyx, c9.yyzy
dp4 oPos.x, c0, r0
dp4 oPos.y, c1, r0
dp4 oPos.z, c2, r0
dp4 oPos.w, c3, r0
mov r0.y, c9.y
slt r0.x, c8.y, r0.y
mad r0.y, v1.y, c9.w, c9.x
mad oT0.y, r0.x, r0.y, v1.y
mov oT0.x, v1.x
mov oT1.xy, v1
slt r0.x, v0.z, -v0.z
frc r0.y, v0.z
add r0.z, -r0.y, v0.z
slt r0.y, -r0.y, r0.y
mad r0.x, r0.x, r0.y, r0.z
mova a0.x, r0.x
mov oT2.xyz, c4[a0.x]
mov oT2.w, v0.z

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedemlifjfkfofplhlilgllkakpeiikmnbjabaaaaaaiiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadp
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaan
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdn
mnmmmmdnmnmmmmdnegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaa
aaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaa
abaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaaf
nccabaaaabaaaaaaagbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaa
aaaaaaaablaaaaafbcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaa
acaaaaaaegiocaaaaaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaaj
cccabaaaacaaaaaaegiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaa
bbaaaaajeccabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefieceddbondbkkkedkcfdmchhcmjmlhejnpfknabaaaaaanmafaaaaaeaaaaaa
daaaaaaaiaacaaaaaaafaaaafeafaaaaebgpgodjeiacaaaaeiacaaaaaaacpopp
aiacaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaakaa
aeaaagaaaaaaaaaaabaaaaaaaeaaakaaaaaaaaaaaaaaafaaaaacpoppfbaaaaaf
aeaaapkamnmmmmdnaaaaaamaaaaaiadpaaaaaaaafbaaaaafaaaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaafbaaaaafabaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaafbaaaaafacaaapkaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaafbaaaaaf
adaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaaciaagaaffkaamaaaaadaaaaabia
aaaaffiaaaaappkaaeaaaaaeaaaaaciaabaaffjaaeaaffkaaeaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaamaaaaadaaaaabiaaaaakkjaaaaakkjb
bdaaaaacaaaaaciaaaaakkjaacaaaaadaaaaaeiaaaaaffibaaaakkjaamaaaaad
aaaaaciaaaaaffibaaaaffiaaeaaaaaeaaaaabiaaaaaaaiaaaaaffiaaaaakkia
coaaaaacaaaaablaaaaaaaiaabaaaaadaaaaapiaaacaoekaaaaaaalaajaaaaad
abaaaboaahaaoekaaaaaoeiaajaaaaadabaaacoaaiaaoekaaaaaoeiaajaaaaad
abaaaeoaajaaoekaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaae
aaaaapiaakaaoekaaaaaaajaaaaaoeiaabaaaaacabaaabiaaeaaaakaaeaaaaae
aaaaapiaamaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaafaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaanoaabaabejaabaaaaacabaaaioaaaaakkjappppaaaa
fdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnmnmmmmdn
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaa
aaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafnccabaaaabaaaaaa
agbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaaaaaaaaaablaaaaaf
bcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaaacaaaaaaegiocaaa
aaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajcccabaaaacaaaaaa
egiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajeccabaaa
acaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaaaaaaaaaadoaaaaab
ejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
faepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 3 [_CameraWS]
Vector 1 [_FogColor]
Vector 2 [_Y]
Vector 0 [_ZBufferParams]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_2_0
def c4, 0, -1.44269502, 0, 0
dcl t0.xy
dcl t1.xy
dcl t2.xy
dcl_2d s0
dcl_2d s1
texld r0, t1, s1
texld r1, t0, s0
mad r0.x, c0.x, r0.x, c0.y
rcp r0.x, r0.x
mad r0.x, r0.x, t2.y, c3.y
add r0.x, r0.x, -c2.x
mul r0.x, r0.x, c2.y
max r2.w, r0.x, c4.x
mul r0.x, r2.w, r2.w
mul r0.x, r0.x, c4.y
exp r0.x, r0.x
lrp_pp r2, r0.x, c1, r1
mov_pp oC0, r2

"
}
SubProgram "d3d11 " {
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 256
Vector 112 [_FogColor]
Vector 144 [_Y]
Vector 240 [_CameraWS]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedagaifohpepibhdppiomgpgahifopnhmlabaaaaaaeeadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapacaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaaakiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkbabaaaacaaaaaabkiacaaa
aaaaaaaaapaaaaaaaaaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaajaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaajaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaadlkklilp
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaajpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaadcaaaaaj
pccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 256
Vector 112 [_FogColor]
Vector 144 [_Y]
Vector 240 [_CameraWS]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedlocaekmnganhhgondhgileobmdajlgbiabaaaaaaniaeaaaaaeaaaaaa
daaaaaaamaabaaaabmaeaaaakeaeaaaaebgpgodjiiabaaaaiiabaaaaaaacpppp
cmabaaaafmaaaaaaaeaacmaaaaaafmaaaaaafmaaacaaceaaaaaafmaaabaaaaaa
aaababaaaaaaahaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaaaaaaapaa
abaaacaaaaaaaaaaabaaahaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapka
aaaaaaaadlkklilpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
abaaaaacaaaaadiaaaaabllaecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaaeaaaaaeaaaaabiaadaaaakaaaaaaaiaadaaffka
agaaaaacaaaaabiaaaaaaaiaaeaaaaaeaaaaabiaaaaaaaiaabaafflaacaaffka
acaaaaadaaaaabiaaaaaaaiaabaaaakbafaaaaadaaaaabiaaaaaaaiaabaaffka
alaaaaadacaaaiiaaaaaaaiaaeaaaakaafaaaaadaaaaabiaacaappiaacaappia
afaaaaadaaaaabiaaaaaaaiaaeaaffkaaoaaaaacaaaaabiaaaaaaaiabcaaaaae
acaacpiaaaaaaaiaaaaaoekaabaaoeiaabaaaaacaaaicpiaacaaoeiappppaaaa
fdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gcbaaaadccbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaalbcaabaaaaaaaaaaaakiacaaaabaaaaaaahaaaaaaakaabaaa
aaaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaaapaaaaaa
aaaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
ajaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
ajaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaadlkklilpbjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaajpcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaadcaaaaajpccabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapacaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  GpuProgramID 166424
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform mat4 _FrustumCornersWS;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec4 tmpvar_2;
  tmpvar_2.xyw = gl_Vertex.xyw;
  vec4 tmpvar_3;
  tmpvar_2.z = 0.1;
  int i_4;
  i_4 = int(gl_Vertex.z);
  vec4 v_5;
  v_5.x = _FrustumCornersWS[0][i_4];
  v_5.y = _FrustumCornersWS[1][i_4];
  v_5.z = _FrustumCornersWS[2][i_4];
  v_5.w = _FrustumCornersWS[3][i_4];
  tmpvar_3.xyz = v_5.xyz;
  tmpvar_3.w = gl_Vertex.z;
  gl_Position = (gl_ModelViewProjectionMatrix * tmpvar_2);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform float _GlobalDensity;
uniform vec4 _FogColor;
uniform vec4 _StartDistance;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = ((1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x)
   + _ZBufferParams.y))) * xlv_TEXCOORD2);
  gl_FragData[0] = mix (_FogColor, texture2D (_MainTex, xlv_TEXCOORD0), vec4(exp((
    -(_GlobalDensity)
   * 
    (clamp (((
      sqrt(dot (tmpvar_1, tmpvar_1))
     * _StartDistance.x) - 1.0), 0.0, 1.0) * _StartDistance.y)
  ))));
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 4 [_FrustumCornersWS]
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_MainTex_TexelSize]
"vs_2_0
def c9, 1, 0, 0.100000001, -2
dcl_position v0
dcl_texcoord v1
mad r0, v0.xyxw, c9.xxyx, c9.yyzy
dp4 oPos.x, c0, r0
dp4 oPos.y, c1, r0
dp4 oPos.z, c2, r0
dp4 oPos.w, c3, r0
mov r0.y, c9.y
slt r0.x, c8.y, r0.y
mad r0.y, v1.y, c9.w, c9.x
mad oT0.y, r0.x, r0.y, v1.y
mov oT0.x, v1.x
mov oT1.xy, v1
slt r0.x, v0.z, -v0.z
frc r0.y, v0.z
add r0.z, -r0.y, v0.z
slt r0.y, -r0.y, r0.y
mad r0.x, r0.x, r0.y, r0.z
mova a0.x, r0.x
mov oT2.xyz, c4[a0.x]
mov oT2.w, v0.z

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedemlifjfkfofplhlilgllkakpeiikmnbjabaaaaaaiiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadp
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaan
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdn
mnmmmmdnmnmmmmdnegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaa
aaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaa
abaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaaf
nccabaaaabaaaaaaagbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaa
aaaaaaaablaaaaafbcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaa
acaaaaaaegiocaaaaaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaaj
cccabaaaacaaaaaaegiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaa
bbaaaaajeccabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefieceddbondbkkkedkcfdmchhcmjmlhejnpfknabaaaaaanmafaaaaaeaaaaaa
daaaaaaaiaacaaaaaaafaaaafeafaaaaebgpgodjeiacaaaaeiacaaaaaaacpopp
aiacaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaakaa
aeaaagaaaaaaaaaaabaaaaaaaeaaakaaaaaaaaaaaaaaafaaaaacpoppfbaaaaaf
aeaaapkamnmmmmdnaaaaaamaaaaaiadpaaaaaaaafbaaaaafaaaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaafbaaaaafabaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaafbaaaaafacaaapkaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaafbaaaaaf
adaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaaciaagaaffkaamaaaaadaaaaabia
aaaaffiaaaaappkaaeaaaaaeaaaaaciaabaaffjaaeaaffkaaeaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaamaaaaadaaaaabiaaaaakkjaaaaakkjb
bdaaaaacaaaaaciaaaaakkjaacaaaaadaaaaaeiaaaaaffibaaaakkjaamaaaaad
aaaaaciaaaaaffibaaaaffiaaeaaaaaeaaaaabiaaaaaaaiaaaaaffiaaaaakkia
coaaaaacaaaaablaaaaaaaiaabaaaaadaaaaapiaaacaoekaaaaaaalaajaaaaad
abaaaboaahaaoekaaaaaoeiaajaaaaadabaaacoaaiaaoekaaaaaoeiaajaaaaad
abaaaeoaajaaoekaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaae
aaaaapiaakaaoekaaaaaaajaaaaaoeiaabaaaaacabaaabiaaeaaaakaaeaaaaae
aaaaapiaamaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaafaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaanoaabaabejaabaaaaacabaaaioaaaaakkjappppaaaa
fdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnmnmmmmdn
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaa
aaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafnccabaaaabaaaaaa
agbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaaaaaaaaaablaaaaaf
bcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaaacaaaaaaegiocaaa
aaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajcccabaaaacaaaaaa
egiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajeccabaaa
acaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaaaaaaaaaadoaaaaab
ejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
faepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 2 [_FogColor]
Float 1 [_GlobalDensity]
Vector 3 [_StartDistance]
Vector 0 [_ZBufferParams]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_2_0
def c4, -1, 1.44269502, 0, 0
dcl t0.xy
dcl t1.xy
dcl t2
dcl_2d s0
dcl_2d s1
texld r0, t1, s1
texld r1, t0, s0
mad r0.x, c0.x, r0.x, c0.y
rcp r0.x, r0.x
mul r0, r0.x, t2
dp4 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r2.w, c3.x
mad_sat r0.x, r0.x, r2.w, c4.x
mul r0.x, r0.x, c3.y
mul r0.x, r0.x, -c1.x
mul r0.x, r0.x, c4.y
exp r0.x, r0.x
lrp_pp r2, r0.x, r1, c2
mov_pp oC0, r2

"
}
SubProgram "d3d11 " {
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 256
Float 96 [_GlobalDensity]
Vector 112 [_FogColor]
Vector 128 [_StartDistance]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedhcklacmcejgjjahkjagfanfenjnebmajabaaaaaafmadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgmacaaaaeaaaaaaajlaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaaakiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbobaaaacaaaaaabbaaaaah
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadccaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaialpdiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaaaaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaiaebaaaaaaaaaaaaaaahaaaaaadcaaaaakpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 256
Float 96 [_GlobalDensity]
Vector 112 [_FogColor]
Vector 128 [_StartDistance]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedjelhpdicnagjndekfkablpfoonpaimafabaaaaaapmaeaaaaaeaaaaaa
daaaaaaammabaaaaeaaeaaaamiaeaaaaebgpgodjjeabaaaajeabaaaaaaacpppp
faabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaabaaaaaa
aaababaaaaaaagaaadaaaaaaaaaaaaaaabaaahaaabaaadaaaaaaaaaaaaacpppp
fbaaaaafaeaaapkaaaaaialpdlkklidpaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaabaaaaacaaaaadiaaaaabllaecaaaaadaaaaapiaaaaaoeia
abaioekaecaaaaadabaaapiaaaaaoelaaaaioekaaeaaaaaeaaaaabiaadaaaaka
aaaaaaiaadaaffkaagaaaaacaaaaabiaaaaaaaiaafaaaaadaaaaapiaaaaaaaia
abaaoelaajaaaaadaaaaabiaaaaaoeiaaaaaoeiaahaaaaacaaaaabiaaaaaaaia
agaaaaacaaaaabiaaaaaaaiaabaaaaacacaaaiiaacaaaakaaeaaaaaeaaaabbia
aaaaaaiaacaappiaaeaaaakaafaaaaadaaaaabiaaaaaaaiaacaaffkaafaaaaad
aaaaabiaaaaaaaiaaaaaaakbafaaaaadaaaaabiaaaaaaaiaaeaaffkaaoaaaaac
aaaaabiaaaaaaaiabcaaaaaeacaacpiaaaaaaaiaabaaoeiaabaaoekaabaaaaac
aaaicpiaacaaoeiappppaaaafdeieefcgmacaaaaeaaaaaaajlaaaaaafjaaaaae
egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadmcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaaakiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbobaaaacaaaaaa
bbaaaaahbcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaakbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaialpdiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaajpcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaiaebaaaaaaaaaaaaaaahaaaaaadcaaaaakpccabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaadoaaaaab
ejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapapaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  GpuProgramID 234300
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform mat4 _FrustumCornersWS;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec4 tmpvar_2;
  tmpvar_2.xyw = gl_Vertex.xyw;
  vec4 tmpvar_3;
  tmpvar_2.z = 0.1;
  int i_4;
  i_4 = int(gl_Vertex.z);
  vec4 v_5;
  v_5.x = _FrustumCornersWS[0][i_4];
  v_5.y = _FrustumCornersWS[1][i_4];
  v_5.z = _FrustumCornersWS[2][i_4];
  v_5.w = _FrustumCornersWS[3][i_4];
  tmpvar_3.xyz = v_5.xyz;
  tmpvar_3.w = gl_Vertex.z;
  gl_Position = (gl_ModelViewProjectionMatrix * tmpvar_2);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform float _GlobalDensity;
uniform vec4 _FogColor;
uniform vec4 _StartDistance;
uniform vec4 _Y;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = ((1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x)
   + _ZBufferParams.y))) * xlv_TEXCOORD2);
  float tmpvar_2;
  tmpvar_2 = max (0.0, ((tmpvar_1.y - _Y.x) * _Y.y));
  gl_FragData[0] = mix (texture2D (_MainTex, xlv_TEXCOORD0), _FogColor, vec4(((1.0 - 
    exp((-(_GlobalDensity) * (clamp (
      ((sqrt(dot (tmpvar_1.xyz, tmpvar_1.xyz)) * _StartDistance.x) - 1.0)
    , 0.0, 1.0) * _StartDistance.y)))
  ) * exp(
    -((tmpvar_2 * tmpvar_2))
  ))));
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 4 [_FrustumCornersWS]
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_MainTex_TexelSize]
"vs_2_0
def c9, 1, 0, 0.100000001, -2
dcl_position v0
dcl_texcoord v1
mad r0, v0.xyxw, c9.xxyx, c9.yyzy
dp4 oPos.x, c0, r0
dp4 oPos.y, c1, r0
dp4 oPos.z, c2, r0
dp4 oPos.w, c3, r0
mov r0.y, c9.y
slt r0.x, c8.y, r0.y
mad r0.y, v1.y, c9.w, c9.x
mad oT0.y, r0.x, r0.y, v1.y
mov oT0.x, v1.x
mov oT1.xy, v1
slt r0.x, v0.z, -v0.z
frc r0.y, v0.z
add r0.z, -r0.y, v0.z
slt r0.y, -r0.y, r0.y
mad r0.x, r0.x, r0.y, r0.z
mova a0.x, r0.x
mov oT2.xyz, c4[a0.x]
mov oT2.w, v0.z

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedemlifjfkfofplhlilgllkakpeiikmnbjabaaaaaaiiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadp
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaan
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdn
mnmmmmdnmnmmmmdnegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaa
aaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaa
abaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaaf
nccabaaaabaaaaaaagbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaa
aaaaaaaablaaaaafbcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaa
acaaaaaaegiocaaaaaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaaj
cccabaaaacaaaaaaegiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaa
bbaaaaajeccabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefieceddbondbkkkedkcfdmchhcmjmlhejnpfknabaaaaaanmafaaaaaeaaaaaa
daaaaaaaiaacaaaaaaafaaaafeafaaaaebgpgodjeiacaaaaeiacaaaaaaacpopp
aiacaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaakaa
aeaaagaaaaaaaaaaabaaaaaaaeaaakaaaaaaaaaaaaaaafaaaaacpoppfbaaaaaf
aeaaapkamnmmmmdnaaaaaamaaaaaiadpaaaaaaaafbaaaaafaaaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaafbaaaaafabaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaafbaaaaafacaaapkaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaafbaaaaaf
adaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaaciaagaaffkaamaaaaadaaaaabia
aaaaffiaaaaappkaaeaaaaaeaaaaaciaabaaffjaaeaaffkaaeaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaamaaaaadaaaaabiaaaaakkjaaaaakkjb
bdaaaaacaaaaaciaaaaakkjaacaaaaadaaaaaeiaaaaaffibaaaakkjaamaaaaad
aaaaaciaaaaaffibaaaaffiaaeaaaaaeaaaaabiaaaaaaaiaaaaaffiaaaaakkia
coaaaaacaaaaablaaaaaaaiaabaaaaadaaaaapiaaacaoekaaaaaaalaajaaaaad
abaaaboaahaaoekaaaaaoeiaajaaaaadabaaacoaaiaaoekaaaaaoeiaajaaaaad
abaaaeoaajaaoekaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaae
aaaaapiaakaaoekaaaaaaajaaaaaoeiaabaaaaacabaaabiaaeaaaakaaeaaaaae
aaaaapiaamaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaafaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaanoaabaabejaabaaaaacabaaaioaaaaakkjappppaaaa
fdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnmnmmmmdn
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaa
aaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafnccabaaaabaaaaaa
agbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaaaaaaaaaablaaaaaf
bcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaaacaaaaaaegiocaaa
aaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajcccabaaaacaaaaaa
egiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajeccabaaa
acaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaaaaaaaaaadoaaaaab
ejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
faepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 2 [_FogColor]
Float 1 [_GlobalDensity]
Vector 3 [_StartDistance]
Vector 4 [_Y]
Vector 0 [_ZBufferParams]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_2_0
def c5, -1, 0, 1.44269502, 1
dcl t0.xy
dcl t1.xy
dcl t2.xyz
dcl_2d s0
dcl_2d s1
texld r0, t1, s1
texld r1, t0, s0
mad r0.x, c0.x, r0.x, c0.y
rcp r0.x, r0.x
mul r2.xyz, r0.x, t2
mad r2.w, r0.x, t2.y, -c4.x
mul r2.w, r2.w, c4.y
max r0.x, r2.w, c5.y
mul r2.w, r0.x, r0.x
mul r2.w, r2.w, -c5.z
exp r2.w, r2.w
dp3 r0.x, r2, r2
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r2.x, c5.x
mad_sat r0.x, r0.x, c3.x, r2.x
mul r0.x, r0.x, c3.y
mul r0.x, r0.x, -c1.x
mul r0.x, r0.x, c5.z
exp r0.x, r0.x
add r0.x, -r0.x, c5.w
mul r0.x, r2.w, r0.x
lrp_pp r2, r0.x, c2, r1
mov_pp oC0, r2

"
}
SubProgram "d3d11 " {
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 256
Float 96 [_GlobalDensity]
Vector 112 [_FogColor]
Vector 128 [_StartDistance]
Vector 144 [_Y]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedeakdcblmgidlogogalffhbpbpidcbmhkabaaaaaaeiaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfiadaaaaeaaaaaaangaaaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaaakiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
diaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaaagbjbaaaacaaaaaadcaaaaal
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaiaebaaaaaa
aaaaaaaaajaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaa
aaaaaaaaajaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaadlkklilpbjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaa
aaaaaaaajgahbaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dccaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaialpdiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaaa
aaaaaaaaaiaaaaaadiaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaagaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaaj
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaa
dcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 256
Float 96 [_GlobalDensity]
Vector 112 [_FogColor]
Vector 128 [_StartDistance]
Vector 144 [_Y]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedhpdkdieolifnpdheahhbdakiighkeibbabaaaaaagiagaaaaaeaaaaaa
daaaaaaaemacaaaakmafaaaadeagaaaaebgpgodjbeacaaaabeacaaaaaaacpppp
naabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaabaaaaaa
aaababaaaaaaagaaaeaaaaaaaaaaaaaaabaaahaaabaaaeaaaaaaaaaaaaacpppp
fbaaaaafafaaapkaaaaaialpaaaaaaaadlkklidpaaaaiadpbpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaabaaaaacaaaaadiaaaaabllaecaaaaadaaaaapiaaaaaoeia
abaioekaecaaaaadabaaapiaaaaaoelaaaaioekaaeaaaaaeaaaaabiaaeaaaaka
aaaaaaiaaeaaffkaagaaaaacaaaaabiaaaaaaaiaafaaaaadacaaahiaaaaaaaia
abaaoelaaeaaaaaeacaaaiiaaaaaaaiaabaafflaadaaaakbafaaaaadacaaaiia
acaappiaadaaffkaalaaaaadaaaaabiaacaappiaafaaffkaafaaaaadacaaaiia
aaaaaaiaaaaaaaiaafaaaaadacaaaiiaacaappiaafaakkkbaoaaaaacacaaaiia
acaappiaaiaaaaadaaaaabiaacaaoeiaacaaoeiaahaaaaacaaaaabiaaaaaaaia
agaaaaacaaaaabiaaaaaaaiaabaaaaacacaaabiaafaaaakaaeaaaaaeaaaabbia
aaaaaaiaacaaaakaacaaaaiaafaaaaadaaaaabiaaaaaaaiaacaaffkaafaaaaad
aaaaabiaaaaaaaiaaaaaaakbafaaaaadaaaaabiaaaaaaaiaafaakkkaaoaaaaac
aaaaabiaaaaaaaiaacaaaaadaaaaabiaaaaaaaibafaappkaafaaaaadaaaaabia
acaappiaaaaaaaiabcaaaaaeacaacpiaaaaaaaiaabaaoekaabaaoeiaabaaaaac
aaaicpiaacaaoeiappppaaaafdeieefcfiadaaaaeaaaaaaangaaaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadmcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaaakiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaadiaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaaagbjbaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaia
ebaaaaaaaaaaaaaaajaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaajaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaadlkklilp
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
jgahbaaaaaaaaaaajgahbaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadccaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaaabeaaaaaaaaaialpdiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadiaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
aaaaaaajpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaa
ahaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}