Shader "FX/Water" {
Properties {
 _WaveScale ("Wave scale", Range(0.02,0.15)) = 0.063
 _ReflDistort ("Reflection distort", Range(0,1.5)) = 0.44
 _RefrDistort ("Refraction distort", Range(0,1.5)) = 0.4
 _RefrColor ("Refraction color", Color) = (0.34,0.85,0.92,1)
 _Fresnel ("Fresnel (A) ", 2D) = "gray" { }
 _BumpMap ("Normalmap ", 2D) = "bump" { }
 WaveSpeed ("Wave speed (map1 x,y; map2 x,y)", Vector) = (19,9,-16,-7)
 _ReflectiveColor ("Reflective color (RGB) fresnel (A) ", 2D) = "" { }
 _ReflectiveColorCube ("Reflective color cube (RGB) fresnel (A)", CUBE) = "" { }
 _HorizonColor ("Simple water horizon color", Color) = (0.172,0.463,0.435,1)
 _MainTex ("Fallback texture", 2D) = "" { }
 _ReflectionTex ("Internal Reflection", 2D) = "" { }
 _RefractionTex ("Internal Refraction", 2D) = "" { }
}
SubShader { 
 Tags { "RenderType"="Opaque" "WATERMODE"="Refractive" }
 Pass {
  Tags { "RenderType"="Opaque" "WATERMODE"="Refractive" }
  GpuProgramID 54513
Program "vp" {
SubProgram "opengl " {
Keywords { "WATER_REFRACTIVE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _World2Object;
uniform vec4 _WaveScale4;
uniform vec4 _WaveOffset;
varying vec4 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 temp_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  temp_1 = ((gl_Vertex.xzxz * _WaveScale4) + _WaveOffset);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_4;
  xlv_TEXCOORD1 = temp_1.xy;
  xlv_TEXCOORD2 = temp_1.wz;
  xlv_TEXCOORD3 = ((_World2Object * tmpvar_3).xyz - gl_Vertex.xyz).xzy;
}


#endif
#ifdef FRAGMENT
uniform float _ReflDistort;
uniform float _RefrDistort;
uniform sampler2D _ReflectionTex;
uniform sampler2D _Fresnel;
uniform sampler2D _RefractionTex;
uniform vec4 _RefrColor;
uniform sampler2D _BumpMap;
varying vec4 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  vec4 uv2_2;
  vec4 uv1_3;
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD1).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6 = ((normal_4 + normal_5) * 0.5);
  uv1_3.zw = tmpvar_1.zw;
  uv1_3.xy = (xlv_TEXCOORD0.xy + (tmpvar_6 * _ReflDistort).xy);
  uv2_2.zw = tmpvar_1.zw;
  uv2_2.xy = (xlv_TEXCOORD0.xy - (tmpvar_6 * _RefrDistort).xy);
  gl_FragData[0] = mix ((texture2DProj (_RefractionTex, uv2_2) * _RefrColor), texture2DProj (_ReflectionTex, uv1_3), texture2D (_Fresnel, vec2(dot (normalize(xlv_TEXCOORD3), tmpvar_6))).wwww);
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFRACTIVE" }
Bind "vertex" Vertex
Matrix 4 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 11 [_WaveOffset]
Vector 10 [_WaveScale4]
Vector 7 [_WorldSpaceCameraPos]
"vs_2_0
def c12, 1, 0, 0.5, 0
dcl_position v0
mov r0.xy, c12
mad r0, c7.xyzx, r0.xxxy, r0.yyyx
dp4 r1.x, c4, r0
dp4 r1.z, c5, r0
dp4 r1.y, c6, r0
add oT3.xyz, r1, -v0.xzyw
dp4 r0.y, c1, v0
mul r1.x, r0.y, c8.x
mul r1.w, r1.x, c12.z
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c12.z
mad oT0.xy, r1.z, c9.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov oPos, r0
mov oT0.zw, r0
mov r0, c10
mad r0, v0.xzxz, r0, c11
mov oT1.xy, r0
mov oT2.xy, r0.wzzw

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFRACTIVE" }
Bind "vertex" Vertex
ConstBuffer "$Globals" 160
Vector 96 [_WaveScale4]
Vector 112 [_WaveOffset]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhhlkmeleglcjcijemlmhpaflbnigdjinabaaaaaamaadaaaaadaaaaaa
cmaaaaaahmaaaaaabmabaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
jmacaaaaeaaaabaakhaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabeaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaalpccabaaaacaaaaaa
igbcbaaaaaaaaaaaegilcaaaaaaaaaaaagaaaaaaegilcaaaaaaaaaaaahaaaaaa
diaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaigibcaaaacaaaaaa
bbaaaaaadcaaaaalhcaabaaaaaaaaaaaigibcaaaacaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaigibcaaa
acaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaigibcaaaacaaaaaabdaaaaaaaaaaaaai
hccabaaaadaaaaaaegacbaaaaaaaaaaaigbbbaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "WATER_REFRACTIVE" }
Bind "vertex" Vertex
ConstBuffer "$Globals" 160
Vector 96 [_WaveScale4]
Vector 112 [_WaveOffset]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednckeanlmnfgjaobpankmdgdeecbcemacabaaaaaaimafaaaaaeaaaaaa
daaaaaaapiabaaaajmaeaaaaomaeaaaaebgpgodjmaabaaaamaabaaaaaaacpopp
giabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaagaa
acaaabaaaaaaaaaaabaaaeaaacaaadaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
acaabaaaaeaaajaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafanaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjaabaaaaacaaaaapia
abaaoekaaeaaaaaeabaaapoaaaaaiijaaaaaoeiaacaaoekaabaaaaacaaaaahia
adaaoekaafaaaaadabaaahiaaaaaffiaakaanikaaeaaaaaeaaaaaliaajaagika
aaaaaaiaabaakeiaaeaaaaaeaaaaahiaalaanikaaaaakkiaaaaapeiaacaaaaad
aaaaahiaaaaaoeiaamaanikaacaaaaadacaaahoaaaaaoeiaaaaanijbafaaaaad
aaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiia
abaaaaiaanaaaakaafaaaaadabaaafiaaaaapeiaanaaaakaacaaaaadaaaaadoa
abaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcjmacaaaa
eaaaabaakhaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabeaaaaaafpaaaaadpcbabaaa
aaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaalpccabaaaacaaaaaaigbcbaaa
aaaaaaaaegilcaaaaaaaaaaaagaaaaaaegilcaaaaaaaaaaaahaaaaaadiaaaaaj
hcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaigibcaaaacaaaaaabbaaaaaa
dcaaaaalhcaabaaaaaaaaaaaigibcaaaacaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaigibcaaaacaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaigibcaaaacaaaaaabdaaaaaaaaaaaaaihccabaaa
adaaaaaaegacbaaaaaaaaaaaigbbbaiaebaaaaaaaaaaaaaadoaaaaabejfdeheo
eiaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaaaaaafaepfdej
feejepeoaaeoepfcenebemaaepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _World2Object;
uniform vec4 _WaveScale4;
uniform vec4 _WaveOffset;
varying vec4 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 temp_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  temp_1 = ((gl_Vertex.xzxz * _WaveScale4) + _WaveOffset);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_4;
  xlv_TEXCOORD1 = temp_1.xy;
  xlv_TEXCOORD2 = temp_1.wz;
  xlv_TEXCOORD3 = ((_World2Object * tmpvar_3).xyz - gl_Vertex.xyz).xzy;
}


#endif
#ifdef FRAGMENT
uniform float _ReflDistort;
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectiveColor;
uniform sampler2D _BumpMap;
varying vec4 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 color_1;
  vec4 uv1_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD1).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = ((normal_3 + normal_4) * 0.5);
  uv1_2.zw = xlv_TEXCOORD0.zw;
  uv1_2.xy = (xlv_TEXCOORD0.xy + (tmpvar_5 * _ReflDistort).xy);
  vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_ReflectionTex, uv1_2);
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ReflectiveColor, vec2(dot (normalize(xlv_TEXCOORD3), tmpvar_5)));
  color_1.xyz = mix (tmpvar_7.xyz, tmpvar_6.xyz, tmpvar_7.www);
  color_1.w = (tmpvar_6.w * tmpvar_7.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" }
Bind "vertex" Vertex
Matrix 4 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 11 [_WaveOffset]
Vector 10 [_WaveScale4]
Vector 7 [_WorldSpaceCameraPos]
"vs_2_0
def c12, 1, 0, 0.5, 0
dcl_position v0
mov r0.xy, c12
mad r0, c7.xyzx, r0.xxxy, r0.yyyx
dp4 r1.x, c4, r0
dp4 r1.z, c5, r0
dp4 r1.y, c6, r0
add oT3.xyz, r1, -v0.xzyw
dp4 r0.y, c1, v0
mul r1.x, r0.y, c8.x
mul r1.w, r1.x, c12.z
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c12.z
mad oT0.xy, r1.z, c9.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov oPos, r0
mov oT0.zw, r0
mov r0, c10
mad r0, v0.xzxz, r0, c11
mov oT1.xy, r0
mov oT2.xy, r0.wzzw

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" }
Bind "vertex" Vertex
ConstBuffer "$Globals" 144
Vector 96 [_WaveScale4]
Vector 112 [_WaveOffset]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhhlkmeleglcjcijemlmhpaflbnigdjinabaaaaaamaadaaaaadaaaaaa
cmaaaaaahmaaaaaabmabaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
jmacaaaaeaaaabaakhaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabeaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaalpccabaaaacaaaaaa
igbcbaaaaaaaaaaaegilcaaaaaaaaaaaagaaaaaaegilcaaaaaaaaaaaahaaaaaa
diaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaigibcaaaacaaaaaa
bbaaaaaadcaaaaalhcaabaaaaaaaaaaaigibcaaaacaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaigibcaaa
acaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaigibcaaaacaaaaaabdaaaaaaaaaaaaai
hccabaaaadaaaaaaegacbaaaaaaaaaaaigbbbaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "WATER_REFLECTIVE" }
Bind "vertex" Vertex
ConstBuffer "$Globals" 144
Vector 96 [_WaveScale4]
Vector 112 [_WaveOffset]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednckeanlmnfgjaobpankmdgdeecbcemacabaaaaaaimafaaaaaeaaaaaa
daaaaaaapiabaaaajmaeaaaaomaeaaaaebgpgodjmaabaaaamaabaaaaaaacpopp
giabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaagaa
acaaabaaaaaaaaaaabaaaeaaacaaadaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
acaabaaaaeaaajaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafanaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjaabaaaaacaaaaapia
abaaoekaaeaaaaaeabaaapoaaaaaiijaaaaaoeiaacaaoekaabaaaaacaaaaahia
adaaoekaafaaaaadabaaahiaaaaaffiaakaanikaaeaaaaaeaaaaaliaajaagika
aaaaaaiaabaakeiaaeaaaaaeaaaaahiaalaanikaaaaakkiaaaaapeiaacaaaaad
aaaaahiaaaaaoeiaamaanikaacaaaaadacaaahoaaaaaoeiaaaaanijbafaaaaad
aaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiia
abaaaaiaanaaaakaafaaaaadabaaafiaaaaapeiaanaaaakaacaaaaadaaaaadoa
abaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcjmacaaaa
eaaaabaakhaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabeaaaaaafpaaaaadpcbabaaa
aaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaalpccabaaaacaaaaaaigbcbaaa
aaaaaaaaegilcaaaaaaaaaaaagaaaaaaegilcaaaaaaaaaaaahaaaaaadiaaaaaj
hcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaigibcaaaacaaaaaabbaaaaaa
dcaaaaalhcaabaaaaaaaaaaaigibcaaaacaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaigibcaaaacaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaigibcaaaacaaaaaabdaaaaaaaaaaaaaihccabaaa
adaaaaaaegacbaaaaaaaaaaaigbbbaiaebaaaaaaaaaaaaaadoaaaaabejfdeheo
eiaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaaaaaafaepfdej
feejepeoaaeoepfcenebemaaepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 _WaveScale4;
uniform vec4 _WaveOffset;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 temp_1;
  temp_1 = ((gl_Vertex.xzxz * _WaveScale4) + _WaveOffset);
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = temp_1.xy;
  xlv_TEXCOORD1 = temp_1.wz;
  xlv_TEXCOORD2 = ((_World2Object * tmpvar_2).xyz - gl_Vertex.xyz).xzy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _ReflectiveColor;
uniform vec4 _HorizonColor;
uniform sampler2D _BumpMap;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 color_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_2.z = sqrt((1.0 - clamp (
    dot (normal_2.xy, normal_2.xy)
  , 0.0, 1.0)));
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD1).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ReflectiveColor, vec2(dot (normalize(xlv_TEXCOORD2), ((normal_2 + normal_3) * 0.5))));
  color_1.xyz = mix (tmpvar_4.xyz, _HorizonColor.xyz, tmpvar_4.www);
  color_1.w = _HorizonColor.w;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" }
Bind "vertex" Vertex
Matrix 4 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 9 [_WaveOffset]
Vector 8 [_WaveScale4]
Vector 7 [_WorldSpaceCameraPos]
"vs_2_0
def c10, 1, 0, 0, 0
dcl_position v0
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mov r0.xy, c10
mad r0, c7.xyzx, r0.xxxy, r0.yyyx
dp4 r1.x, c4, r0
dp4 r1.z, c5, r0
dp4 r1.y, c6, r0
add oT2.xyz, r1, -v0.xzyw
mov r0, c8
mad r0, v0.xzxz, r0, c9
mov oT0.xy, r0
mov oT1.xy, r0.wzzw

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" }
Bind "vertex" Vertex
ConstBuffer "$Globals" 144
Vector 96 [_WaveScale4]
Vector 112 [_WaveOffset]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhgognpbdofobcicdfbcnmgddogaomjmgabaaaaaabaadaaaaadaaaaaa
cmaaaaaahmaaaaaaaeabaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcaeacaaaaeaaaabaaibaaaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
beaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaalpccabaaaabaaaaaaigbcbaaaaaaaaaaaegilcaaaaaaaaaaa
agaaaaaaegilcaaaaaaaaaaaahaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaa
abaaaaaaaeaaaaaaigibcaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaa
igibcaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaigibcaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
igibcaaaacaaaaaabdaaaaaaaaaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaa
igbbbaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "WATER_SIMPLE" }
Bind "vertex" Vertex
ConstBuffer "$Globals" 144
Vector 96 [_WaveScale4]
Vector 112 [_WaveOffset]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedgdaabiheofanmbabmppgfacgndfgooplabaaaaaahiaeaaaaaeaaaaaa
daaaaaaajeabaaaakaadaaaapaadaaaaebgpgodjfmabaaaafmabaaaaaaacpopp
aeabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaagaa
acaaabaaaaaaaaaaabaaaeaaabaaadaaaaaaaaaaacaaaaaaaeaaaeaaaaaaaaaa
acaabaaaaeaaaiaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
abaaaaacaaaaapiaabaaoekaaeaaaaaeaaaaapoaaaaaiijaaaaaoeiaacaaoeka
abaaaaacaaaaahiaadaaoekaafaaaaadabaaahiaaaaaffiaajaanikaaeaaaaae
aaaaaliaaiaagikaaaaaaaiaabaakeiaaeaaaaaeaaaaahiaakaanikaaaaakkia
aaaapeiaacaaaaadaaaaahiaaaaaoeiaalaanikaacaaaaadabaaahoaaaaaoeia
aaaanijbafaaaaadaaaaapiaaaaaffjaafaaoekaaeaaaaaeaaaaapiaaeaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaahaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcaeacaaaaeaaaabaa
ibaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaabeaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaalpccabaaaabaaaaaa
igbcbaaaaaaaaaaaegilcaaaaaaaaaaaagaaaaaaegilcaaaaaaaaaaaahaaaaaa
diaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaigibcaaaacaaaaaa
bbaaaaaadcaaaaalhcaabaaaaaaaaaaaigibcaaaacaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaigibcaaa
acaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaigibcaaaacaaaaaabdaaaaaaaaaaaaai
hccabaaaacaaaaaaegacbaaaaaaaaaaaigbbbaiaebaaaaaaaaaaaaaadoaaaaab
ejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaaaaaa
faepfdejfeejepeoaaeoepfcenebemaaepfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
abaaaaaaamadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "WATER_REFRACTIVE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFRACTIVE" }
Float 0 [_ReflDistort]
Vector 2 [_RefrColor]
Float 1 [_RefrDistort]
SetTexture 0 [_ReflectionTex] 2D 0
SetTexture 1 [_Fresnel] 2D 1
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
"ps_2_0
def c3, 2, -1, 0, 1
def c4, 0.5, 0, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
dcl t3.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texld_pp r0, t1, s3
texld_pp r1, t2, s3
mad_pp r2.x, r0.w, c3.x, c3.y
mad_pp r2.y, r0.y, c3.x, c3.y
dp2add_sat_pp r2.w, r2, r2, c3.z
add_pp r2.w, -r2.w, c3.w
rsq_pp r2.w, r2.w
rcp_pp r2.z, r2.w
mad_pp r0.x, r1.w, c3.x, c3.y
mad_pp r0.y, r1.y, c3.x, c3.y
dp2add_sat_pp r0.w, r0, r0, c3.z
add_pp r0.w, -r0.w, c3.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
add_pp r0.xyz, r0, r2
mul_pp r0.xyz, r0, c4.x
mad r1.xy, r0, c0.x, t0
mov r1.zw, t0
mad r2.xy, r0, -c1.x, t0
mov r2.zw, t0
nrm r3.xyz, t3
dp3_pp r0.xy, r3, r0
texldp_pp r1, r1, s0
texldp r2, r2, s2
texld_pp r0, r0, s1
mad_pp r1, r2, -c2, r1
mul_pp r2, r2, c2
mad_pp r0, r0.w, r1, r2
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFRACTIVE" }
SetTexture 0 [_BumpMap] 2D 3
SetTexture 1 [_ReflectionTex] 2D 0
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_Fresnel] 2D 1
ConstBuffer "$Globals" 160
Float 128 [_ReflDistort]
Float 132 [_RefrDistort]
Vector 144 [_RefrColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmndmmifoabeeieohbeoglejlhdeboeknabaaaaaaieafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefchmaeaaaaeaaaaaaabpabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
adaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
abaaaaaadkaabaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaakdcaabaaaabaaaaaaegaabaaa
aaaaaaaaagiacaaaaaaaaaaaaiaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadcaaaaaldcaabaaa
acaaaaaaegaabaiaebaaaaaaaaaaaaaafgifcaaaaaaaaaaaaiaaaaaaegbabaaa
abaaaaaaaoaaaaahdcaabaaaacaaaaaaegaabaaaacaaaaaapgbpbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaalpcaabaaaabaaaaaaegaobaiaebaaaaaaacaaaaaaegiocaaa
aaaaaaaaajaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegiocaaaaaaaaaaaajaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaagaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadcaaaaaj
pccabaaaaaaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "WATER_REFRACTIVE" }
SetTexture 0 [_BumpMap] 2D 3
SetTexture 1 [_ReflectionTex] 2D 0
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_Fresnel] 2D 1
ConstBuffer "$Globals" 160
Float 128 [_ReflDistort]
Float 132 [_RefrDistort]
Vector 144 [_RefrColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkjhbcepjhfomdmiecmdjipmmeilbgmgpabaaaaaafeaiaaaaaeaaaaaa
daaaaaaapmacaaaaiaahaaaacaaiaaaaebgpgodjmeacaaaameacaaaaaaacpppp
ieacaaaaeaaaaaaaabaadeaaaaaaeaaaaaaaeaaaaeaaceaaaaaaeaaaabaaaaaa
adababaaacacacaaaaadadaaaaaaaiaaacaaaaaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafadaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
abaaaaacaaaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaadaioekaecaaaaad
abaacpiaabaaoelaadaioekaaeaaaaaeacaacbiaaaaappiaacaaaakaacaaffka
aeaaaaaeacaacciaaaaaffiaacaaaakaacaaffkafkaaaaaeacaadiiaacaaoeia
acaaoeiaacaakkkaacaaaaadacaaciiaacaappibacaappkaahaaaaacacaaciia
acaappiaagaaaaacacaaceiaacaappiaaeaaaaaeaaaacbiaabaappiaacaaaaka
acaaffkaaeaaaaaeaaaacciaabaaffiaacaaaakaacaaffkafkaaaaaeaaaadiia
aaaaoeiaaaaaoeiaacaakkkaacaaaaadaaaaciiaaaaappibacaappkaahaaaaac
aaaaciiaaaaappiaagaaaaacaaaaceiaaaaappiaacaaaaadaaaachiaacaaoeia
aaaaoeiaafaaaaadaaaachiaaaaaoeiaadaaaakaaeaaaaaeabaaadiaaaaaoeia
aaaaaakaaaaaoelaagaaaaacaaaaaiiaaaaapplaafaaaaadabaaadiaaaaappia
abaaoeiaaeaaaaaeabaaamiaaaaabliaaaaaffkbaaaabllaafaaaaadacaaadia
aaaappiaabaabliaceaaaaacadaaahiaacaaoelaaiaaaaadaaaacdiaadaaoeia
aaaaoeiaecaaaaadabaacpiaabaaoeiaaaaioekaecaaaaadacaaapiaacaaoeia
acaioekaecaaaaadaaaacpiaaaaaoeiaabaioekaaeaaaaaeabaacpiaacaaoeia
abaaoekbabaaoeiaafaaaaadacaacpiaacaaoeiaabaaoekaaeaaaaaeaaaacpia
aaaappiaabaaoeiaacaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
hmaeaaaaeaaaaaaabpabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaaaaaaaaa
hgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaa
aaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaa
dcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaa
dkaabaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadcaaaaakdcaabaaaabaaaaaaegaabaaaaaaaaaaa
agiacaaaaaaaaaaaaiaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadcaaaaaldcaabaaaacaaaaaa
egaabaiaebaaaaaaaaaaaaaafgifcaaaaaaaaaaaaiaaaaaaegbabaaaabaaaaaa
aoaaaaahdcaabaaaacaaaaaaegaabaaaacaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
dcaaaaalpcaabaaaabaaaaaaegaobaiaebaaaaaaacaaaaaaegiocaaaaaaaaaaa
ajaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaa
egiocaaaaaaaaaaaajaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadcaaaaajpccabaaa
aaaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadoaaaaab
ejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapalaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" }
Float 0 [_ReflDistort]
SetTexture 0 [_ReflectionTex] 2D 0
SetTexture 1 [_ReflectiveColor] 2D 1
SetTexture 2 [_BumpMap] 2D 2
"ps_2_0
def c1, 2, -1, 0, 1
def c2, 0.5, 0, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
dcl t3.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, t1, s2
texld_pp r1, t2, s2
mad_pp r2.x, r0.w, c1.x, c1.y
mad_pp r2.y, r0.y, c1.x, c1.y
dp2add_sat_pp r2.w, r2, r2, c1.z
add_pp r2.w, -r2.w, c1.w
rsq_pp r2.w, r2.w
rcp_pp r2.z, r2.w
mad_pp r0.x, r1.w, c1.x, c1.y
mad_pp r0.y, r1.y, c1.x, c1.y
dp2add_sat_pp r0.w, r0, r0, c1.z
add_pp r0.w, -r0.w, c1.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
add_pp r0.xyz, r0, r2
mul_pp r0.xyz, r0, c2.x
nrm r1.xyz, t3
dp3_pp r1.xy, r1, r0
mad r0.xy, r0, c0.x, t0
mov r0.zw, t0
texld_pp r1, r1, s1
texldp_pp r0, r0, s0
lrp_pp r2.xyz, r1.w, r0, r1
mul_pp r2.w, r1.w, r0.w
mov_pp oC0, r2

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" }
SetTexture 0 [_BumpMap] 2D 2
SetTexture 1 [_ReflectionTex] 2D 0
SetTexture 2 [_ReflectiveColor] 2D 1
ConstBuffer "$Globals" 144
Float 128 [_ReflDistort]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgbpjmcbdigjhjhnoplahidbaepbgcklpabaaaaaaomaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoeadaaaaeaaaaaaapjaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaa
ddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaaegbabaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegaabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egbcbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "WATER_REFLECTIVE" }
SetTexture 0 [_BumpMap] 2D 2
SetTexture 1 [_ReflectionTex] 2D 0
SetTexture 2 [_ReflectiveColor] 2D 1
ConstBuffer "$Globals" 144
Float 128 [_ReflDistort]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkjeepolflliinbmmpmhcjdelodaoncigabaaaaaageahaaaaaeaaaaaa
daaaaaaakeacaaaajaagaaaadaahaaaaebgpgodjgmacaaaagmacaaaaaaacpppp
daacaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaabaaaaaa
acababaaaaacacaaaaaaaiaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapka
aaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafacaaapkaaaaaaadpaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaapla
bpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkaabaaaaacaaaaadiaabaabllaecaaaaad
aaaacpiaaaaaoeiaacaioekaecaaaaadabaacpiaabaaoelaacaioekaaeaaaaae
acaacbiaaaaappiaabaaaakaabaaffkaaeaaaaaeacaacciaaaaaffiaabaaaaka
abaaffkafkaaaaaeacaadiiaacaaoeiaacaaoeiaabaakkkaacaaaaadacaaciia
acaappibabaappkaahaaaaacacaaciiaacaappiaagaaaaacacaaceiaacaappia
aeaaaaaeaaaacbiaabaappiaabaaaakaabaaffkaaeaaaaaeaaaacciaabaaffia
abaaaakaabaaffkafkaaaaaeaaaadiiaaaaaoeiaaaaaoeiaabaakkkaacaaaaad
aaaaciiaaaaappibabaappkaahaaaaacaaaaciiaaaaappiaagaaaaacaaaaceia
aaaappiaacaaaaadaaaachiaacaaoeiaaaaaoeiaafaaaaadaaaachiaaaaaoeia
acaaaakaaeaaaaaeabaaadiaaaaaoeiaaaaaaakaaaaaoelaagaaaaacaaaaaiia
aaaapplaafaaaaadabaaadiaaaaappiaabaaoeiaceaaaaacacaaahiaacaaoela
aiaaaaadaaaacdiaacaaoeiaaaaaoeiaecaaaaadabaacpiaabaaoeiaaaaioeka
ecaaaaadaaaacpiaaaaaoeiaabaioekabcaaaaaeacaachiaaaaappiaabaaoeia
aaaaoeiaafaaaaadacaaciiaaaaappiaabaappiaabaaaaacaaaicpiaacaaoeia
ppppaaaafdeieefcoeadaaaaeaaaaaaapjaaaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadlcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaa
dkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
abaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaakdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaaegbabaaaabaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegbcbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" }
Vector 0 [_HorizonColor]
SetTexture 0 [_ReflectiveColor] 2D 0
SetTexture 1 [_BumpMap] 2D 1
"ps_2_0
def c1, 2, -1, 0, 1
def c2, 0.5, 0, 0, 0
dcl t0.xy
dcl t1.xy
dcl t2.xyz
dcl_2d s0
dcl_2d s1
texld_pp r0, t0, s1
texld_pp r1, t1, s1
mad_pp r2.x, r0.w, c1.x, c1.y
mad_pp r2.y, r0.y, c1.x, c1.y
dp2add_sat_pp r2.w, r2, r2, c1.z
add_pp r2.w, -r2.w, c1.w
rsq_pp r2.w, r2.w
rcp_pp r2.z, r2.w
mad_pp r0.x, r1.w, c1.x, c1.y
mad_pp r0.y, r1.y, c1.x, c1.y
dp2add_sat_pp r0.w, r0, r0, c1.z
add_pp r0.w, -r0.w, c1.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
add_pp r0.xyz, r0, r2
mul_pp r0.xyz, r0, c2.x
nrm r1.xyz, t2
dp3_pp r0.xy, r1, r0
texld_pp r0, r0, s0
lrp_pp r1.xyz, r0.w, c0, r0
mov_pp r1.w, c0.w
mov_pp oC0, r1

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_ReflectiveColor] 2D 0
ConstBuffer "$Globals" 144
Vector 128 [_HorizonColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmkaoikncobbgkphjfmgklockkjbabpgdabaaaaaaeeaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaanfaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaa
ddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaagaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaadcaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "WATER_SIMPLE" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_ReflectiveColor] 2D 0
ConstBuffer "$Globals" 144
Vector 128 [_HorizonColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedoaclfbbofemjedmojnnlppiigihheeenabaaaaaafmagaaaaaeaaaaaa
daaaaaaaeeacaaaakaafaaaaciagaaaaebgpgodjamacaaaaamacaaaaaaacpppp
neabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaabaaaaaa
aaababaaaaaaaiaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaea
aaaaialpaaaaaaaaaaaaiadpfbaaaaafacaaapkaaaaaaadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaahlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaacaaaaadiaaaaablla
ecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadabaacpiaaaaaoelaabaioeka
aeaaaaaeacaacbiaaaaappiaabaaaakaabaaffkaaeaaaaaeacaacciaaaaaffia
abaaaakaabaaffkafkaaaaaeacaadiiaacaaoeiaacaaoeiaabaakkkaacaaaaad
acaaciiaacaappibabaappkaahaaaaacacaaciiaacaappiaagaaaaacacaaceia
acaappiaaeaaaaaeaaaacbiaabaappiaabaaaakaabaaffkaaeaaaaaeaaaaccia
abaaffiaabaaaakaabaaffkafkaaaaaeaaaadiiaaaaaoeiaaaaaoeiaabaakkka
acaaaaadaaaaciiaaaaappibabaappkaahaaaaacaaaaciiaaaaappiaagaaaaac
aaaaceiaaaaappiaacaaaaadaaaachiaacaaoeiaaaaaoeiaafaaaaadaaaachia
aaaaoeiaacaaaakaceaaaaacabaaahiaabaaoelaaiaaaaadaaaacdiaabaaoeia
aaaaoeiaecaaaaadaaaacpiaaaaaoeiaaaaioekabcaaaaaeabaachiaaaaappia
aaaaoekaaaaaoeiaabaaaaacabaaciiaaaaappkaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcfeadaaaaeaaaaaaanfaaaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
abaaaaaadkaabaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaagaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaa
dcaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadoaaaaab
ejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="Opaque" "WATERMODE"="Simple" }
 Pass {
  Tags { "RenderType"="Opaque" "WATERMODE"="Simple" }
  Color (0.5,0.5,0.5,0.5)
  SetTexture [_MainTex] { combine texture * primary }
  SetTexture [_MainTex] { combine texture * primary + previous }
  SetTexture [_ReflectiveColorCube] { combine texture + previous, primary alpha }
 }
}
SubShader { 
 Tags { "RenderType"="Opaque" "WATERMODE"="Simple" }
 Pass {
  Tags { "RenderType"="Opaque" "WATERMODE"="Simple" }
  Color (0.5,0.5,0.5,0.5)
  SetTexture [_MainTex] { combine texture }
  SetTexture [_ReflectiveColorCube] { combine texture + previous, primary alpha }
 }
}
SubShader { 
 Tags { "RenderType"="Opaque" "WATERMODE"="Simple" }
 Pass {
  Tags { "RenderType"="Opaque" "WATERMODE"="Simple" }
  Color (0.5,0.5,0.5,0)
  SetTexture [_MainTex] { combine texture, primary alpha }
 }
}
}