Shader "Custom/Translucent" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
 _BumpMap ("Normal (Normal)", 2D) = "bump" { }
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.03,1)) = 0.078125
 _Thickness ("Thickness (R)", 2D) = "bump" { }
 _Power ("Subsurface Power", Float) = 1
 _Distortion ("Subsurface Distortion", Float) = 0
 _Scale ("Subsurface Scale", Float) = 0.5
 _SubColor ("Subsurface Color", Color) = (1,1,1,1)
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 4345
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
  vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * TANGENT.w);
  vec4 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_5.x;
  tmpvar_9.w = tmpvar_1.x;
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7.y;
  tmpvar_10.y = tmpvar_8.y;
  tmpvar_10.z = tmpvar_5.y;
  tmpvar_10.w = tmpvar_1.y;
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_7.z;
  tmpvar_11.y = tmpvar_8.z;
  tmpvar_11.z = tmpvar_5.z;
  tmpvar_11.w = tmpvar_1.z;
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_5;
  vec3 x2_13;
  vec3 x1_14;
  x1_14.x = dot (unity_SHAr, tmpvar_12);
  x1_14.y = dot (unity_SHAg, tmpvar_12);
  x1_14.z = dot (unity_SHAb, tmpvar_12);
  vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_13.x = dot (unity_SHBr, tmpvar_15);
  x2_13.y = dot (unity_SHBg, tmpvar_15);
  x2_13.z = dot (unity_SHBb, tmpvar_15);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = ((x2_13 + (unity_SHC.xyz * 
    ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y))
  )) + x1_14);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_10;
  tmpvar_10 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_9 + tmpvar_8)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_7.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_9)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_10)
  ) * 2.0) + ((tmpvar_5 * _LightColor0.xyz) * (
    ((2.0 * (pow (
      max (0.0, dot (tmpvar_8, -((tmpvar_9 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_7.w = ((_LightColor0.w * _SpecColor.w) * tmpvar_10);
  c_2.xyz = (c_2 + c_7).xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 17 [_MainTex_ST]
Vector 12 [unity_SHAb]
Vector 11 [unity_SHAg]
Vector 10 [unity_SHAr]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_2_0
def c18, 1, 0, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v3, c17, c17.zwzw
dp4 oT1.w, c4, v0
dp4 oT2.w, c5, v0
dp4 oT3.w, c6, v0
mul r0.xyz, v2.y, c8
mad r0.xyz, c7, v2.x, r0
mad r0.xyz, c9, v2.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mad r0.xyz, c16, r0.x, r3
mov r1.w, c18.x
dp4 r2.x, c10, r1
dp4 r2.y, c11, r1
dp4 r2.z, c12, r1
add oT4.xyz, r0, r2
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r2.xyz, r0, r1.zxyw
mad r2.xyz, r1.yzxw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.x
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.y
mov oT3.z, r1.z

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhbdmhcacfapoljfcfpmdpdnfeggenngoabaaaaaaciajaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
eeahaaaaeaaaabaanbabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaa
anaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
abaaaaaajgiecaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaa
acaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaacaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaacaaaaaa
akiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaacaaaaaa
akiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaacaaaaaa
akiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaacaaaaaa
bkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaacaaaaaa
bkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaacaaaaaa
bkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaaacaaaaaackiacaaa
acaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaaacaaaaaackiacaaa
acaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaaacaaaaaackiacaaa
acaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
abaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaajgaebaaaacaaaaaa
jgaebaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaa
adaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaa
acaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaa
dgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaaadaaaaaa
bkaabaaaaaaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaaaaaaaaadgaaaaaf
eccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaa
adaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaadaaaaaadgaaaaafeccabaaa
aeaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaacaaaaaa
bkaabaaaacaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaajgacbaaa
acaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
cmaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaacaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedeoiancengmcnjnlfkjgkkhbegojmbhkpabaaaaaafaanaaaaaeaaaaaa
daaaaaaafeaeaaaakaalaaaajiamaaaaebgpgodjbmaeaaaabmaeaaaaaaacpopp
meadaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaanaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaahaaanaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbeaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaabiaacaaaajabbaaaaka
afaaaaadaaaaaciaacaaaajabcaaaakaafaaaaadaaaaaeiaacaaaajabdaaaaka
afaaaaadabaaabiaacaaffjabbaaffkaafaaaaadabaaaciaacaaffjabcaaffka
afaaaaadabaaaeiaacaaffjabdaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
afaaaaadabaaabiaacaakkjabbaakkkaafaaaaadabaaaciaacaakkjabcaakkka
afaaaaadabaaaeiaacaakkjabdaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
ceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaae
aaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeia
ajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaadadaaaciaagaaoekaacaaoeia
ajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaaaaia
adaaoeiaabaaaaacabaaaiiabeaaaakaajaaaaadacaaabiaacaaoekaabaaoeia
ajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaadacaaaeiaaeaaoekaabaaoeia
acaaaaadaeaaahoaaaaaoeiaacaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoeka
aeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaafaaaaad
aaaaahiaabaaffjaaoaamjkaaeaaaaaeaaaaahiaanaamjkaabaaaajaaaaaoeia
aeaaaaaeaaaaahiaapaamjkaabaakkjaaaaaoeiaaiaaaaadaaaaaiiaaaaaoeia
aaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadaaaaahiaaaaappiaaaaaoeia
abaaaaacabaaaboaaaaakkiaafaaaaadacaaahiaaaaaoeiaabaanciaaeaaaaae
acaaahiaabaamjiaaaaamjiaacaaoeibafaaaaadacaaahiaacaaoeiaabaappja
abaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoaabaaaaiaafaaaaadadaaahia
aaaaffjaaoaaoekaaeaaaaaeadaaahiaanaaoekaaaaaaajaadaaoeiaaeaaaaae
adaaahiaapaaoekaaaaakkjaadaaoeiaaeaaaaaeadaaahiabaaaoekaaaaappja
adaaoeiaabaaaaacabaaaioaadaaaaiaabaaaaacacaaaboaaaaaaaiaabaaaaac
adaaaboaaaaaffiaabaaaaacacaaacoaacaaffiaabaaaaacadaaacoaacaakkia
abaaaaacacaaaeoaabaaffiaabaaaaacadaaaeoaabaakkiaabaaaaacacaaaioa
adaaffiaabaaaaacadaaaioaadaakkiappppaaaafdeieefceeahaaaaeaaaabaa
nbabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaacaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaajgiecaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaacaaaaaaamaaaaaa
agbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaa
acaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
bcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
baaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
bbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
bcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaibcaabaaaadaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaacgajbaaa
acaaaaaadcaaaaakhcaabaaaadaaaaaajgaebaaaacaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaadaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaacaaaaaaakaabaaa
acaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaaaaaaaaaa
dgaaaaaficcabaaaaeaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaadaaaaaa
bkaabaaaacaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaadaaaaaadgaaaaaf
cccabaaaaeaaaaaackaabaaaadaaaaaadgaaaaafeccabaaaaeaaaaaackaabaaa
acaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaaakaabaia
ebaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaajgacbaaaacaaaaaaegakbaaa
acaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
abaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
abaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaa
aaaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaacaaaaaa
aaaaaaahhccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_DynamicLightmapST;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * TANGENT.xyz));
  vec3 tmpvar_9;
  tmpvar_9 = (((tmpvar_6.yzx * tmpvar_8.zxy) - (tmpvar_6.zxy * tmpvar_8.yzx)) * TANGENT.w);
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_8.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = tmpvar_6.x;
  tmpvar_10.w = tmpvar_2.x;
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = tmpvar_6.y;
  tmpvar_11.w = tmpvar_2.y;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_8.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = tmpvar_6.z;
  tmpvar_12.w = tmpvar_2.z;
  tmpvar_1.zw = ((gl_MultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD7 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D unity_DynamicLightmap;
uniform vec4 unity_DynamicLightmap_HDR;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_10;
  tmpvar_10 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_9 + tmpvar_8)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_7.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_9)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_10)
  ) * 2.0) + ((tmpvar_5 * _LightColor0.xyz) * (
    ((2.0 * (pow (
      max (0.0, dot (tmpvar_8, -((tmpvar_9 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_7.w = ((_LightColor0.w * _SpecColor.w) * tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD7.zw);
  c_2.xyz = ((c_2 + c_7).xyz + (tmpvar_5 * pow (
    ((unity_DynamicLightmap_HDR.x * tmpvar_11.w) * tmpvar_11.xyz)
  , unity_DynamicLightmap_HDR.yyy)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_MainTex_ST]
Vector 10 [unity_DynamicLightmapST]
"vs_3_0
def c12, 0, 0, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord2 v4
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord7 o6
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c11, c11.zwzw
dp4 o2.w, c4, v0
dp4 o3.w, c5, v0
dp4 o4.w, c6, v0
mad o6.zw, v4.xyxy, c10.xyxy, c10
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x
mov o5.xyz, c12.x
mov o6.xy, c12.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityLightmaps" 32
Vector 16 [unity_DynamicLightmapST]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityLightmaps" 2
"vs_4_0
eefiecedoppgodmiibcmiencoeimomkplioannofabaaaaaaemaiaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapadaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaalmaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfaagaaaaeaaaabaa
jeabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaad
pccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadiaaaaai
hcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaadaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
adaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficcabaaaacaaaaaa
akaabaaaadaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaaadaaaaaa
dgaaaaaficcabaaaaeaaaaaackaabaaaadaaaaaadgaaaaafcccabaaaadaaaaaa
bkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadgaaaaai
hccabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadcaaaaal
mccabaaaagaaaaaaagbebaaaafaaaaaaagiecaaaacaaaaaaabaaaaaakgiocaaa
acaaaaaaabaaaaaadgaaaaaidccabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * TANGENT.xyz));
  vec3 tmpvar_9;
  tmpvar_9 = (((tmpvar_6.yzx * tmpvar_8.zxy) - (tmpvar_6.zxy * tmpvar_8.yzx)) * TANGENT.w);
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_8.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = tmpvar_6.x;
  tmpvar_10.w = tmpvar_2.x;
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = tmpvar_6.y;
  tmpvar_11.w = tmpvar_2.y;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_8.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = tmpvar_6.z;
  tmpvar_12.w = tmpvar_2.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  vec3 x2_14;
  vec3 x1_15;
  x1_15.x = dot (unity_SHAr, tmpvar_13);
  x1_15.y = dot (unity_SHAg, tmpvar_13);
  x1_15.z = dot (unity_SHAb, tmpvar_13);
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_14.x = dot (unity_SHBr, tmpvar_16);
  x2_14.y = dot (unity_SHBg, tmpvar_16);
  x2_14.z = dot (unity_SHBb, tmpvar_16);
  vec4 o_17;
  vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_1 * 0.5);
  vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = ((x2_14 + (unity_SHC.xyz * 
    ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y))
  )) + x1_15);
  xlv_TEXCOORD5 = o_17;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_8;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_11;
  tmpvar_11 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_10 + tmpvar_9)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_8.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_10)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_11)
  ) * (tmpvar_7.x * 2.0)) + ((tmpvar_5 * _LightColor0.xyz) * (
    (((tmpvar_7.x * 2.0) * (pow (
      max (0.0, dot (tmpvar_9, -((tmpvar_10 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_8.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_11) * tmpvar_7.x);
  c_2.xyz = (c_2 + c_8).xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 19 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c20, 1, 0.5, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
mad oT0.xy, v3, c19, c19.zwzw
dp4 oT1.w, c4, v0
dp4 oT2.w, c5, v0
dp4 oT3.w, c6, v0
mul r0.xyz, v2.y, c8
mad r0.xyz, c7, v2.x, r0
mad r0.xyz, c9, v2.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c15, r2
dp4 r3.y, c16, r2
dp4 r3.z, c17, r2
mad r0.xyz, c18, r0.x, r3
mov r1.w, c20.x
dp4 r2.x, c12, r1
dp4 r2.y, c13, r1
dp4 r2.z, c14, r1
add oT4.xyz, r0, r2
dp4 r0.y, c1, v0
mul r1.w, r0.y, c10.x
mul r2.w, r1.w, c20.y
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r2.xz, r0.xyww, c20.y
mad oT5.xy, r2.z, c11.zwzw, r2.xwzw
dp4 r0.z, c2, v0
mov oPos, r0
mov oT5.zw, r0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r2.xyz, r0, r1.zxyw
mad r2.xyz, r1.yzxw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.x
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.y
mov oT3.z, r1.z

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedffcpjciafbffapmjhklnebabbbilfohhabaaaaaaoiajaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcomahaaaaeaaaabaa
plabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaa
ogikcaaaaaaaaaaaanaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaafgbfbaaaabaaaaaajgiecaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
acaaaaaajgiecaaaadaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaajgiecaaaadaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaadaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaaeaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaeaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaeaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaegacbaaaaeaaaaaadiaaaaaibcaabaaaaeaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaeaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaeaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaadaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaa
aeaaaaaaegacbaaaacaaaaaacgajbaaaadaaaaaadcaaaaakhcaabaaaaeaaaaaa
jgaebaaaadaaaaaajgaebaaaacaaaaaaegacbaiaebaaaaaaaeaaaaaadiaaaaah
hcaabaaaaeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaa
acaaaaaaakaabaaaaeaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaacaaaaaa
dgaaaaafeccabaaaacaaaaaaakaabaaaadaaaaaadgaaaaafbccabaaaadaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaacaaaaaadgaaaaaf
iccabaaaadaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaa
abaaaaaadgaaaaafeccabaaaadaaaaaabkaabaaaadaaaaaadgaaaaafcccabaaa
adaaaaaabkaabaaaaeaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaaeaaaaaa
dgaaaaafeccabaaaaeaaaaaackaabaaaadaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaa
adaaaaaaakaabaaaadaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaadaaaaaaegakbaaaadaaaaaabbaaaaaibcaabaaaaeaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaaeaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaaeaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaaeaaaaaadgaaaaaf
icaabaaaadaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaa
acaaaaaacgaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaa
acaaaaaachaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaa
acaaaaaaciaaaaaaegaobaaaadaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaagaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_DynamicLightmapST;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_5.xyz * gl_Normal.y)
  ) + (v_6.xyz * gl_Normal.z)));
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * TANGENT.xyz));
  vec3 tmpvar_10;
  tmpvar_10 = (((tmpvar_7.yzx * tmpvar_9.zxy) - (tmpvar_7.zxy * tmpvar_9.yzx)) * TANGENT.w);
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.y = tmpvar_10.x;
  tmpvar_11.z = tmpvar_7.x;
  tmpvar_11.w = tmpvar_3.x;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_9.y;
  tmpvar_12.y = tmpvar_10.y;
  tmpvar_12.z = tmpvar_7.y;
  tmpvar_12.w = tmpvar_3.y;
  vec4 tmpvar_13;
  tmpvar_13.x = tmpvar_9.z;
  tmpvar_13.y = tmpvar_10.z;
  tmpvar_13.z = tmpvar_7.z;
  tmpvar_13.w = tmpvar_3.z;
  tmpvar_1.zw = ((gl_MultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
  vec4 o_14;
  vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_2 * 0.5);
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD5 = o_14;
  xlv_TEXCOORD7 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D unity_DynamicLightmap;
uniform vec4 unity_DynamicLightmap_HDR;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_8;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_11;
  tmpvar_11 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_10 + tmpvar_9)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_8.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_10)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_11)
  ) * (tmpvar_7.x * 2.0)) + ((tmpvar_5 * _LightColor0.xyz) * (
    (((tmpvar_7.x * 2.0) * (pow (
      max (0.0, dot (tmpvar_9, -((tmpvar_10 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_8.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_11) * tmpvar_7.x);
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD7.zw);
  c_2.xyz = ((c_2 + c_8).xyz + (tmpvar_5 * pow (
    ((unity_DynamicLightmap_HDR.x * tmpvar_12.w) * tmpvar_12.xyz)
  , unity_DynamicLightmap_HDR.yyy)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 12 [unity_DynamicLightmapST]
"vs_3_0
def c14, 0.5, 0, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord2 v4
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord7 o7
mad o1.xy, v3, c13, c13.zwzw
dp4 o2.w, c4, v0
dp4 o3.w, c5, v0
dp4 o4.w, c6, v0
mad o7.zw, v4.xyxy, c12.xyxy, c12
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c14.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c14.x
mad o6.xy, r1.z, c11.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o6.zw, r0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x
mov o5.xyz, c14.y
mov o7.xy, c14.y

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityLightmaps" 32
Vector 16 [unity_DynamicLightmapST]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityLightmaps" 3
"vs_4_0
eefiecedpmkipdbjkifiobpjknakfglimnnnnffkabaaaaaaamajaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapadaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcpiagaaaaeaaaabaaloabaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaabdaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaac
afaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaai
ccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaai
ccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaai
ecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaai
bcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiecaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaibcaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafeccabaaaacaaaaaabkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaabaaaaaajgiecaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
jgiecaaaacaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaajgiecaaaacaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaacgajbaaaabaaaaaa
jgaebaaaacaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaa
adaaaaaadiaaaaaihcaabaaaaeaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaeaaaaaadgaaaaaf
iccabaaaacaaaaaaakaabaaaaeaaaaaadgaaaaafbccabaaaacaaaaaackaabaaa
acaaaaaadgaaaaafeccabaaaadaaaaaackaabaaaabaaaaaadgaaaaafeccabaaa
aeaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaacaaaaaa
dgaaaaafbccabaaaaeaaaaaabkaabaaaacaaaaaadgaaaaaficcabaaaadaaaaaa
bkaabaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaaeaaaaaadgaaaaaf
cccabaaaadaaaaaabkaabaaaadaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaa
adaaaaaadgaaaaaihccabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaal
mccabaaaahaaaaaaagbebaaaafaaaaaaagiecaaaadaaaaaaabaaaaaakgiocaaa
adaaaaaaabaaaaaadgaaaaaidccabaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
  vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * TANGENT.w);
  vec4 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_5.x;
  tmpvar_9.w = tmpvar_1.x;
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7.y;
  tmpvar_10.y = tmpvar_8.y;
  tmpvar_10.z = tmpvar_5.y;
  tmpvar_10.w = tmpvar_1.y;
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_7.z;
  tmpvar_11.y = tmpvar_8.z;
  tmpvar_11.z = tmpvar_5.z;
  tmpvar_11.w = tmpvar_1.z;
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_5;
  vec3 x2_13;
  vec3 x1_14;
  x1_14.x = dot (unity_SHAr, tmpvar_12);
  x1_14.y = dot (unity_SHAg, tmpvar_12);
  x1_14.z = dot (unity_SHAb, tmpvar_12);
  vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_13.x = dot (unity_SHBr, tmpvar_15);
  x2_13.y = dot (unity_SHBg, tmpvar_15);
  x2_13.z = dot (unity_SHBb, tmpvar_15);
  vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_1.x);
  vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_1.y);
  vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_1.z);
  vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * tmpvar_5.x) + (tmpvar_17 * tmpvar_5.y)) + (tmpvar_18 * tmpvar_5.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = (((x2_13 + 
    (unity_SHC.xyz * ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y)))
  ) + x1_14) + ((
    ((unity_LightColor[0].xyz * tmpvar_20.x) + (unity_LightColor[1].xyz * tmpvar_20.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_20.z)
  ) + (unity_LightColor[3].xyz * tmpvar_20.w)));
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_10;
  tmpvar_10 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_9 + tmpvar_8)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_7.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_9)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_10)
  ) * 2.0) + ((tmpvar_5 * _LightColor0.xyz) * (
    ((2.0 * (pow (
      max (0.0, dot (tmpvar_8, -((tmpvar_9 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_7.w = ((_LightColor0.w * _SpecColor.w) * tmpvar_10);
  c_2.xyz = (c_2 + c_7).xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 25 [_MainTex_ST]
Vector 17 [unity_4LightAtten0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 20 [unity_SHAb]
Vector 19 [unity_SHAg]
Vector 18 [unity_SHAr]
Vector 23 [unity_SHBb]
Vector 22 [unity_SHBg]
Vector 21 [unity_SHBr]
Vector 24 [unity_SHC]
"vs_2_0
def c26, 1, 0, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c4, v0
dp4 oPos.y, c5, v0
dp4 oPos.z, c6, v0
dp4 oPos.w, c7, v0
mad oT0.xy, v3, c25, c25.zwzw
dp4 r0.x, c9, v0
add r1, -r0.x, c15
mov oT2.w, r0.x
mul r0, r1, r1
dp4 r2.x, c8, v0
add r3, -r2.x, c14
mov oT1.w, r2.x
mad r0, r3, r3, r0
dp4 r2.x, c10, v0
add r4, -r2.x, c16
mov oT3.w, r2.x
mad r0, r4, r4, r0
rsq r2.x, r0.x
rsq r2.y, r0.y
rsq r2.z, r0.z
rsq r2.w, r0.w
mov r5.x, c26.x
mad r0, r0, c17, r5.x
mul r5.xyz, v2.y, c12
mad r5.xyz, c11, v2.x, r5
mad r5.xyz, c13, v2.z, r5
nrm r6.xyz, r5
mul r1, r1, r6.y
mad r1, r3, r6.x, r1
mad r1, r4, r6.z, r1
mul r1, r2, r1
max r1, r1, c26.y
rcp r2.x, r0.x
rcp r2.y, r0.y
rcp r2.z, r0.z
rcp r2.w, r0.w
mul r0, r1, r2
mul r1.xyz, r0.y, c1
mad r1.xyz, c0, r0.x, r1
mad r0.xyz, c2, r0.z, r1
mad r0.xyz, c3, r0.w, r0
mul r0.w, r6.y, r6.y
mad r0.w, r6.x, r6.x, -r0.w
mul r1, r6.yzzx, r6.xyzz
dp4 r2.x, c21, r1
dp4 r2.y, c22, r1
dp4 r2.z, c23, r1
mad r1.xyz, c24, r0.w, r2
mov r6.w, c26.x
dp4 r2.x, c18, r6
dp4 r2.y, c19, r6
dp4 r2.z, c20, r6
add r1.xyz, r1, r2
add oT4.xyz, r0, r1
dp3 r0.z, c8, v1
dp3 r0.x, c9, v1
dp3 r0.y, c10, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, r0, r6.zxyw
mad r1.xyz, r6.yzxw, r0.yzxw, -r1
mul r1.xyz, r1, v1.w
mov oT1.y, r1.x
mov oT1.z, r6.x
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r1.y
mov oT3.y, r1.z
mov oT2.z, r6.y
mov oT3.z, r6.z

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddgnkilameefjplcgefjkmkplkhcmmgmnabaaaaaaoaalaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
pmajaaaaeaaaabaahpacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacagaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaa
anaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaabaaaaaajgiecaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaajgiecaaaacaaaaaaamaaaaaaagbabaaa
abaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaajgiecaaaacaaaaaa
aoaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafbccabaaaacaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaacgajbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaa
jgaebaaaabaaaaaajgaebaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaa
acaaaaaaakaabaaaacaaaaaadgaaaaafeccabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficcabaaa
acaaaaaaakaabaaaadaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaaaaaaaaa
dgaaaaafbccabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaafcccabaaaadaaaaaa
bkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadgaaaaaf
eccabaaaadaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaa
adaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaadaaaaaadgaaaaafeccabaaa
aeaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
abaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
cmaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadgaaaaaficaabaaaabaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaajpcaabaaaacaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaa
abaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
aaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaaabaaaaaa
acaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaa
abaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaa
abaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaa
kgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaa
afaaaaaaegaobaaaafaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaacaaaaaa
egaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaaeeaaaaafpcaabaaa
adaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaa
egiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
aoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
egaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
adaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
abaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaaagaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaahhccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedifppnaomickljnblbdnphbfcjfdjldababaaaaaamabbaaaaaeaaaaaa
daaaaaaaamagaaaababaaaaaaibbaaaaebgpgodjneafaaaaneafaaaaaaacpopp
haafaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaanaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaacgaaahaaakaaaaaaaaaa
acaaaaaaaeaabbaaaaaaaaaaacaaamaaahaabfaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbmaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaabiaacaaaajabjaaaakaafaaaaadaaaaaciaacaaaajabkaaaakaafaaaaad
aaaaaeiaacaaaajablaaaakaafaaaaadabaaabiaacaaffjabjaaffkaafaaaaad
abaaaciaacaaffjabkaaffkaafaaaaadabaaaeiaacaaffjablaaffkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjabjaakkkaafaaaaad
abaaaciaacaakkjabkaakkkaafaaaaadabaaaeiaacaakkjablaakkkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaahia
aaaaffjabgaaoekaaeaaaaaeaaaaahiabfaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiabhaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabiaaoekaaaaappja
aaaaoeiaacaaaaadacaaapiaaaaaffibadaaoekaafaaaaadadaaapiaabaaffia
acaaoeiaafaaaaadacaaapiaacaaoeiaacaaoeiaacaaaaadaeaaapiaaaaaaaib
acaaoekaaeaaaaaeadaaapiaaeaaoeiaabaaaaiaadaaoeiaaeaaaaaeacaaapia
aeaaoeiaaeaaoeiaacaaoeiaacaaaaadaeaaapiaaaaakkibaeaaoekaaeaaaaae
adaaapiaaeaaoeiaabaakkiaadaaoeiaaeaaaaaeacaaapiaaeaaoeiaaeaaoeia
acaaoeiaahaaaaacaeaaabiaacaaaaiaahaaaaacaeaaaciaacaaffiaahaaaaac
aeaaaeiaacaakkiaahaaaaacaeaaaiiaacaappiaabaaaaacafaaabiabmaaaaka
aeaaaaaeacaaapiaacaaoeiaafaaoekaafaaaaiaafaaaaadadaaapiaadaaoeia
aeaaoeiaalaaaaadadaaapiaadaaoeiabmaaffkaagaaaaacaeaaabiaacaaaaia
agaaaaacaeaaaciaacaaffiaagaaaaacaeaaaeiaacaakkiaagaaaaacaeaaaiia
acaappiaafaaaaadacaaapiaadaaoeiaaeaaoeiaafaaaaadadaaahiaacaaffia
ahaaoekaaeaaaaaeadaaahiaagaaoekaacaaaaiaadaaoeiaaeaaaaaeacaaahia
aiaaoekaacaakkiaadaaoeiaaeaaaaaeacaaahiaajaaoekaacaappiaacaaoeia
afaaaaadaaaaaiiaabaaffiaabaaffiaaeaaaaaeaaaaaiiaabaaaaiaabaaaaia
aaaappibafaaaaadadaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaanaaoeka
adaaoeiaajaaaaadaeaaaciaaoaaoekaadaaoeiaajaaaaadaeaaaeiaapaaoeka
adaaoeiaaeaaaaaeadaaahiabaaaoekaaaaappiaaeaaoeiaabaaaaacabaaaiia
bmaaaakaajaaaaadaeaaabiaakaaoekaabaaoeiaajaaaaadaeaaaciaalaaoeka
abaaoeiaajaaaaadaeaaaeiaamaaoekaabaaoeiaacaaaaadadaaahiaadaaoeia
aeaaoeiaacaaaaadaeaaahoaacaaoeiaadaaoeiaafaaaaadacaaapiaaaaaffja
bcaaoekaaeaaaaaeacaaapiabbaaoekaaaaaaajaacaaoeiaaeaaaaaeacaaapia
bdaaoekaaaaakkjaacaaoeiaaeaaaaaeacaaapiabeaaoekaaaaappjaacaaoeia
aeaaaaaeaaaaadmaacaappiaaaaaoekaacaaoeiaabaaaaacaaaaammaacaaoeia
afaaaaadacaaahiaabaaffjabgaamjkaaeaaaaaeacaaahiabfaamjkaabaaaaja
acaaoeiaaeaaaaaeacaaahiabhaamjkaabaakkjaacaaoeiaaiaaaaadaaaaaiia
acaaoeiaacaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadacaaahiaaaaappia
acaaoeiaabaaaaacabaaaboaacaakkiaafaaaaadadaaahiaabaanciaacaaoeia
aeaaaaaeadaaahiaabaamjiaacaamjiaadaaoeibafaaaaadadaaahiaadaaoeia
abaappjaabaaaaacabaaacoaadaaaaiaabaaaaacabaaaeoaabaaaaiaabaaaaac
abaaaioaaaaaaaiaabaaaaacacaaaboaacaaaaiaabaaaaacadaaaboaacaaffia
abaaaaacacaaacoaadaaffiaabaaaaacadaaacoaadaakkiaabaaaaacacaaaeoa
abaaffiaabaaaaacadaaaeoaabaakkiaabaaaaacacaaaioaaaaaffiaabaaaaac
adaaaioaaaaakkiappppaaaafdeieefcpmajaaaaeaaaabaahpacaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaae
egiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaabaaaaaajgiecaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgiecaaaacaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaajgiecaaaacaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafbccabaaaacaaaaaackaabaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
bcaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
bcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaa
diaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaa
diaaaaaiecaabaaaacaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaacgajbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaajgaebaaaabaaaaaajgaebaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
eccabaaaacaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaadaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaadaaaaaadgaaaaaf
bccabaaaadaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaa
aaaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaa
aeaaaaaackaabaaaacaaaaaadgaaaaafeccabaaaadaaaaaabkaabaaaabaaaaaa
dgaaaaaficcabaaaadaaaaaabkaabaaaadaaaaaadgaaaaaficcabaaaaeaaaaaa
ckaabaaaadaaaaaadgaaaaafeccabaaaaeaaaaaackaabaaaabaaaaaadiaaaaah
bcaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
aeaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
acaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
acaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaa
acaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaabaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaa
fgafbaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaa
aeaaaaaafgafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaacaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaia
ebaaaaaaadaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaa
kgakbaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaa
aeaaaaaaegaobaaaafaaaaaaagaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaacaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaa
acaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaacaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaan
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaajaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
oaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_DynamicLightmapST;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * TANGENT.xyz));
  vec3 tmpvar_9;
  tmpvar_9 = (((tmpvar_6.yzx * tmpvar_8.zxy) - (tmpvar_6.zxy * tmpvar_8.yzx)) * TANGENT.w);
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_8.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = tmpvar_6.x;
  tmpvar_10.w = tmpvar_2.x;
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = tmpvar_6.y;
  tmpvar_11.w = tmpvar_2.y;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_8.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = tmpvar_6.z;
  tmpvar_12.w = tmpvar_2.z;
  tmpvar_1.zw = ((gl_MultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - tmpvar_2.x);
  vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - tmpvar_2.y);
  vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - tmpvar_2.z);
  vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * tmpvar_6.x) + (tmpvar_14 * tmpvar_6.y)) + (tmpvar_15 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  xlv_TEXCOORD7 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D unity_DynamicLightmap;
uniform vec4 unity_DynamicLightmap_HDR;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_10;
  tmpvar_10 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_9 + tmpvar_8)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_7.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_9)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_10)
  ) * 2.0) + ((tmpvar_5 * _LightColor0.xyz) * (
    ((2.0 * (pow (
      max (0.0, dot (tmpvar_8, -((tmpvar_9 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_7.w = ((_LightColor0.w * _SpecColor.w) * tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD7.zw);
  c_2.xyz = ((c_2 + c_7).xyz + (tmpvar_5 * pow (
    ((unity_DynamicLightmap_HDR.x * tmpvar_11.w) * tmpvar_11.xyz)
  , unity_DynamicLightmap_HDR.yyy)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 19 [_MainTex_ST]
Vector 17 [unity_4LightAtten0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 18 [unity_DynamicLightmapST]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
"vs_3_0
def c20, 0, 1, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord2 v4
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord7 o6
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.z, c6, v0
dp4 o0.w, c7, v0
mad o1.xy, v3, c19, c19.zwzw
mad o6.zw, v4.xyxy, c18.xyxy, c18
dp4 r0.x, c8, v0
add r1, -r0.x, c14
mov o2.w, r0.x
dp4 r0.x, c9, v0
add r2, -r0.x, c15
mov o3.w, r0.x
mul r0.xyz, c12.zxyw, v2.y
mad r0.xyz, c11.zxyw, v2.x, r0
mad r0.xyz, c13.zxyw, v2.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mul r3, r0.z, r2
mul r2, r2, r2
mad r2, r1, r1, r2
mad r1, r1, r0.y, r3
dp4 r0.w, c10, v0
add r3, -r0.w, c16
mov o4.zw, r0.xyxw
mad r1, r3, r0.x, r1
mad r2, r3, r3, r2
rsq r3.x, r2.x
rsq r3.y, r2.y
rsq r3.z, r2.z
rsq r3.w, r2.w
mov r4.y, c20.y
mad r2, r2, c17, r4.y
mul r1, r1, r3
max r1, r1, c20.x
rcp r3.x, r2.x
rcp r3.y, r2.y
rcp r3.z, r2.z
rcp r3.w, r2.w
mul r1, r1, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad o5.xyz, c3, r1.w, r1
dp3 r1.z, c8, v1
dp3 r1.x, c9, v1
dp3 r1.y, c10, v1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mov o2.x, r1.z
mul r2.xyz, r0, r1
mad r2.xyz, r0.zxyw, r1.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r0.y
mov o3.x, r1.x
mov o4.x, r1.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r0.z
mov o6.xy, c20.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityLightmaps" 32
Vector 16 [unity_DynamicLightmapST]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityLightmaps" 3
"vs_4_0
eefiecednokpgmoafncianldpobbenfcgeicfdemabaaaaaaniakaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapadaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaalmaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcnmaiaaaaeaaaabaa
dhacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
akaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaaeegiocaaaadaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacafaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaa
anaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
baaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
bbaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
bcaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
baaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
bbaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaajgiecaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaacaaaaaaamaaaaaa
agbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaa
acaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaa
abaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaa
diaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficcabaaa
acaaaaaaakaabaaaadaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaa
dgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaa
ckaabaaaaaaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaaf
cccabaaaaeaaaaaackaabaaaacaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaa
adaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaaficcabaaa
aeaaaaaackaabaaaadaaaaaaaaaaaaajpcaabaaaabaaaaaafgafbaiaebaaaaaa
adaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaabaaaaaaaaaaaaajpcaabaaaaeaaaaaaagaabaiaebaaaaaaadaaaaaa
egiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaiaebaaaaaa
adaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaa
aeaaaaaafgafbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaa
egaobaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaabaaaaaadcaaaaaj
pcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaa
eeaaaaafpcaabaaaacaaaaaaegaobaaaabaaaaaadcaaaaanpcaabaaaabaaaaaa
egaobaaaabaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpaoaaaaakpcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaacaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaalmccabaaaagaaaaaaagbebaaaafaaaaaaagiecaaa
adaaaaaaabaaaaaakgiocaaaadaaaaaaabaaaaaadgaaaaaidccabaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * TANGENT.xyz));
  vec3 tmpvar_9;
  tmpvar_9 = (((tmpvar_6.yzx * tmpvar_8.zxy) - (tmpvar_6.zxy * tmpvar_8.yzx)) * TANGENT.w);
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_8.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = tmpvar_6.x;
  tmpvar_10.w = tmpvar_2.x;
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = tmpvar_6.y;
  tmpvar_11.w = tmpvar_2.y;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_8.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = tmpvar_6.z;
  tmpvar_12.w = tmpvar_2.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  vec3 x2_14;
  vec3 x1_15;
  x1_15.x = dot (unity_SHAr, tmpvar_13);
  x1_15.y = dot (unity_SHAg, tmpvar_13);
  x1_15.z = dot (unity_SHAb, tmpvar_13);
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_14.x = dot (unity_SHBr, tmpvar_16);
  x2_14.y = dot (unity_SHBg, tmpvar_16);
  x2_14.z = dot (unity_SHBb, tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_2.x);
  vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_2.y);
  vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_2.z);
  vec4 tmpvar_20;
  tmpvar_20 = (((tmpvar_17 * tmpvar_17) + (tmpvar_18 * tmpvar_18)) + (tmpvar_19 * tmpvar_19));
  vec4 tmpvar_21;
  tmpvar_21 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_17 * tmpvar_6.x) + (tmpvar_18 * tmpvar_6.y)) + (tmpvar_19 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_20)
  )) * (1.0/((1.0 + 
    (tmpvar_20 * unity_4LightAtten0)
  ))));
  vec4 o_22;
  vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_1 * 0.5);
  vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = (((x2_14 + 
    (unity_SHC.xyz * ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y)))
  ) + x1_15) + ((
    ((unity_LightColor[0].xyz * tmpvar_21.x) + (unity_LightColor[1].xyz * tmpvar_21.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_21.z)
  ) + (unity_LightColor[3].xyz * tmpvar_21.w)));
  xlv_TEXCOORD5 = o_22;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_8;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_11;
  tmpvar_11 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_10 + tmpvar_9)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_8.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_10)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_11)
  ) * (tmpvar_7.x * 2.0)) + ((tmpvar_5 * _LightColor0.xyz) * (
    (((tmpvar_7.x * 2.0) * (pow (
      max (0.0, dot (tmpvar_9, -((tmpvar_10 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_8.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_11) * tmpvar_7.x);
  c_2.xyz = (c_2 + c_8).xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 27 [_MainTex_ST]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 19 [unity_4LightAtten0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 22 [unity_SHAb]
Vector 21 [unity_SHAg]
Vector 20 [unity_SHAr]
Vector 25 [unity_SHBb]
Vector 24 [unity_SHBg]
Vector 23 [unity_SHBr]
Vector 26 [unity_SHC]
"vs_2_0
def c28, 1, 0, 0.5, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
mad oT0.xy, v3, c27, c27.zwzw
dp4 r0.x, c9, v0
add r1, -r0.x, c17
mov oT2.w, r0.x
mul r0, r1, r1
dp4 r2.x, c8, v0
add r3, -r2.x, c16
mov oT1.w, r2.x
mad r0, r3, r3, r0
dp4 r2.x, c10, v0
add r4, -r2.x, c18
mov oT3.w, r2.x
mad r0, r4, r4, r0
rsq r2.x, r0.x
rsq r2.y, r0.y
rsq r2.z, r0.z
rsq r2.w, r0.w
mov r5.x, c28.x
mad r0, r0, c19, r5.x
mul r5.xyz, v2.y, c12
mad r5.xyz, c11, v2.x, r5
mad r5.xyz, c13, v2.z, r5
nrm r6.xyz, r5
mul r1, r1, r6.y
mad r1, r3, r6.x, r1
mad r1, r4, r6.z, r1
mul r1, r2, r1
max r1, r1, c28.y
rcp r2.x, r0.x
rcp r2.y, r0.y
rcp r2.z, r0.z
rcp r2.w, r0.w
mul r0, r1, r2
mul r1.xyz, r0.y, c1
mad r1.xyz, c0, r0.x, r1
mad r0.xyz, c2, r0.z, r1
mad r0.xyz, c3, r0.w, r0
mul r0.w, r6.y, r6.y
mad r0.w, r6.x, r6.x, -r0.w
mul r1, r6.yzzx, r6.xyzz
dp4 r2.x, c23, r1
dp4 r2.y, c24, r1
dp4 r2.z, c25, r1
mad r1.xyz, c26, r0.w, r2
mov r6.w, c28.x
dp4 r2.x, c20, r6
dp4 r2.y, c21, r6
dp4 r2.z, c22, r6
add r1.xyz, r1, r2
add oT4.xyz, r0, r1
dp4 r0.y, c5, v0
mul r1.x, r0.y, c14.x
mul r1.w, r1.x, c28.z
dp4 r0.x, c4, v0
dp4 r0.w, c7, v0
mul r1.xz, r0.xyww, c28.z
mad oT5.xy, r1.z, c15.zwzw, r1.xwzw
dp4 r0.z, c6, v0
mov oPos, r0
mov oT5.zw, r0
dp3 r0.z, c8, v1
dp3 r0.x, c9, v1
dp3 r0.y, c10, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, r0, r6.zxyw
mad r1.xyz, r6.yzxw, r0.yzxw, -r1
mul r1.xyz, r1, v1.w
mov oT1.y, r1.x
mov oT1.z, r6.x
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r1.y
mov oT3.y, r1.z
mov oT2.z, r6.y
mov oT3.z, r6.z

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbelgehgembmpnjkofabebaalihikipnjabaaaaaakaamaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckeakaaaaeaaaabaa
kjacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaa
ogikcaaaaaaaaaaaanaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaadaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaadaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadiaaaaai
bcaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaa
adaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
adaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
adaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaacgajbaaaacaaaaaadcaaaaak
hcaabaaaadaaaaaajgaebaaaacaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaa
dgaaaaafcccabaaaacaaaaaaakaabaaaadaaaaaadgaaaaafeccabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaaihcaabaaaaeaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaa
aeaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaeaaaaaa
dgaaaaaficcabaaaacaaaaaaakaabaaaaeaaaaaadgaaaaafbccabaaaadaaaaaa
akaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaf
cccabaaaadaaaaaabkaabaaaadaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaa
adaaaaaadgaaaaafeccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaaficcabaaa
adaaaaaabkaabaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaaeaaaaaa
dgaaaaafeccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaa
acaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaa
adaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaaafaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaafaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaafaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaafaaaaaadgaaaaaf
icaabaaaacaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaachaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaciaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaa
aeaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaafaaaaaafgafbaaa
acaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaadaaaaaaaaaaaaajpcaabaaaagaaaaaaagaabaiaebaaaaaaaeaaaaaa
egiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaaeaaaaaakgakbaiaebaaaaaa
aeaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaa
agaaaaaaagaabaaaacaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaacaaaaaa
egaobaaaaeaaaaaakgakbaaaacaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaa
adaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaaegaobaaaadaaaaaadcaaaaaj
pcaabaaaadaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaadaaaaaa
eeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaanpcaabaaaadaaaaaa
egaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
egaobaaaadaaaaaaegaobaaaacaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaa
acaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
acaaaaaaagaaaaaaagaabaaaacaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaacaaaaaa
egacbaaaacaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_DynamicLightmapST;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_5.xyz * gl_Normal.y)
  ) + (v_6.xyz * gl_Normal.z)));
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * TANGENT.xyz));
  vec3 tmpvar_10;
  tmpvar_10 = (((tmpvar_7.yzx * tmpvar_9.zxy) - (tmpvar_7.zxy * tmpvar_9.yzx)) * TANGENT.w);
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.y = tmpvar_10.x;
  tmpvar_11.z = tmpvar_7.x;
  tmpvar_11.w = tmpvar_3.x;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_9.y;
  tmpvar_12.y = tmpvar_10.y;
  tmpvar_12.z = tmpvar_7.y;
  tmpvar_12.w = tmpvar_3.y;
  vec4 tmpvar_13;
  tmpvar_13.x = tmpvar_9.z;
  tmpvar_13.y = tmpvar_10.z;
  tmpvar_13.z = tmpvar_7.z;
  tmpvar_13.w = tmpvar_3.z;
  tmpvar_1.zw = ((gl_MultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
  vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - tmpvar_3.x);
  vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - tmpvar_3.y);
  vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - tmpvar_3.z);
  vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * tmpvar_7.x) + (tmpvar_15 * tmpvar_7.y)) + (tmpvar_16 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  vec4 o_19;
  vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_2 * 0.5);
  vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  xlv_TEXCOORD5 = o_19;
  xlv_TEXCOORD7 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D unity_DynamicLightmap;
uniform vec4 unity_DynamicLightmap_HDR;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_8;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_11;
  tmpvar_11 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_10 + tmpvar_9)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_8.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_10)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_11)
  ) * (tmpvar_7.x * 2.0)) + ((tmpvar_5 * _LightColor0.xyz) * (
    (((tmpvar_7.x * 2.0) * (pow (
      max (0.0, dot (tmpvar_9, -((tmpvar_10 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_8.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_11) * tmpvar_7.x);
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD7.zw);
  c_2.xyz = ((c_2 + c_8).xyz + (tmpvar_5 * pow (
    ((unity_DynamicLightmap_HDR.x * tmpvar_12.w) * tmpvar_12.xyz)
  , unity_DynamicLightmap_HDR.yyy)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 21 [_MainTex_ST]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 19 [unity_4LightAtten0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 20 [unity_DynamicLightmapST]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
"vs_3_0
def c22, 0, 1, 0.5, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord2 v4
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord7 o7
mad o1.xy, v3, c21, c21.zwzw
mad o7.zw, v4.xyxy, c20.xyxy, c20
dp4 r0.x, c8, v0
add r1, -r0.x, c16
mov o2.w, r0.x
dp4 r0.x, c9, v0
add r2, -r0.x, c17
mov o3.w, r0.x
mul r0.xyz, c12.zxyw, v2.y
mad r0.xyz, c11.zxyw, v2.x, r0
mad r0.xyz, c13.zxyw, v2.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mul r3, r0.z, r2
mul r2, r2, r2
mad r2, r1, r1, r2
mad r1, r1, r0.y, r3
dp4 r0.w, c10, v0
add r3, -r0.w, c18
mov o4.zw, r0.xyxw
mad r1, r3, r0.x, r1
mad r2, r3, r3, r2
rsq r3.x, r2.x
rsq r3.y, r2.y
rsq r3.z, r2.z
rsq r3.w, r2.w
mov r4.y, c22.y
mad r2, r2, c19, r4.y
mul r1, r1, r3
max r1, r1, c22.x
rcp r3.x, r2.x
rcp r3.y, r2.y
rcp r3.z, r2.z
rcp r3.w, r2.w
mul r1, r1, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad o5.xyz, c3, r1.w, r1
dp4 r1.y, c5, v0
mul r0.w, r1.y, c14.x
mul r2.w, r0.w, c22.z
dp4 r1.x, c4, v0
dp4 r1.w, c7, v0
mul r2.xz, r1.xyww, c22.z
mad o6.xy, r2.z, c15.zwzw, r2.xwzw
dp4 r1.z, c6, v0
mov o0, r1
mov o6.zw, r1
dp3 r1.z, c8, v1
dp3 r1.x, c9, v1
dp3 r1.y, c10, v1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mov o2.x, r1.z
mul r2.xyz, r0, r1
mad r2.xyz, r0.zxyw, r1.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r0.y
mov o3.x, r1.x
mov o4.x, r1.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r0.z
mov o7.xy, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityLightmaps" 32
Vector 16 [unity_DynamicLightmapST]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityLightmaps" 4
"vs_4_0
eefiecedcignpojgoopagcaanhjjkmmdfggogdmdabaaaaaajialaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapadaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcieajaaaaeaaaabaagbacaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaakaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafjaaaaae
egiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
gfaaaaadpccabaaaahaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaa
ogikcaaaaaaaaaaaanaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabcaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabaaaaaaadiaaaaaiecaabaaaacaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabbaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabaaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabbaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaa
abaaaaaajgiecaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaajgiecaaa
adaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaajgiecaaaadaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaacgajbaaaabaaaaaajgaebaaa
acaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaadaaaaaa
dgaaaaafeccabaaaacaaaaaabkaabaaaabaaaaaadgaaaaafbccabaaaacaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaeaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaa
aeaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaeaaaaaa
dgaaaaaficcabaaaacaaaaaaakaabaaaaeaaaaaadgaaaaafbccabaaaadaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaacaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaa
adaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaadaaaaaadgaaaaaficcabaaa
adaaaaaabkaabaaaaeaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaabaaaaaa
dgaaaaaficcabaaaaeaaaaaackaabaaaaeaaaaaaaaaaaaajpcaabaaaacaaaaaa
fgafbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaa
adaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaacaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaia
ebaaaaaaaeaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaaeaaaaaa
kgakbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaa
adaaaaaaegaobaaaafaaaaaafgafbaaaabaaaaaaegaobaaaadaaaaaadcaaaaaj
pcaabaaaabaaaaaaegaobaaaaeaaaaaaagaabaaaabaaaaaaegaobaaaadaaaaaa
dcaaaaajpcaabaaaacaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaa
acaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaa
egaobaaaacaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaan
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaacaaaaaaajaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
agaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadcaaaaalmccabaaaahaaaaaaagbebaaaafaaaaaaagiecaaa
aeaaaaaaabaaaaaakgiocaaaaeaaaaaaabaaaaaadgaaaaaidccabaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedjcmbidkheamniegcieeombfbblnecplpabaaaaaafiapaaaaaeaaaaaa
daaaaaaapiaeaaaajaanaaaaiiaoaaaaebgpgodjmaaeaaaamaaeaaaaaaacpopp
fmaeaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaanaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaiaaaeaaajaaaaaaaaaa
adaaaaaaaeaaanaaaaaaaaaaadaaamaaahaabbaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbiaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaabiaacaaaajabfaaaakaafaaaaadaaaaaciaacaaaajabgaaaakaafaaaaad
aaaaaeiaacaaaajabhaaaakaafaaaaadabaaabiaacaaffjabfaaffkaafaaaaad
abaaaciaacaaffjabgaaffkaafaaaaadabaaaeiaacaaffjabhaaffkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjabfaakkkaafaaaaad
abaaaciaacaakkjabgaakkkaafaaaaadabaaaeiaacaakkjabhaakkkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabia
abaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaad
acaaapiaabaacjiaabaakeiaajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaad
adaaaciaagaaoekaacaaoeiaajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaae
aaaaahiaaiaaoekaaaaaaaiaadaaoeiaabaaaaacabaaaiiabiaaaakaajaaaaad
acaaabiaacaaoekaabaaoeiaajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaad
acaaaeiaaeaaoekaabaaoeiaacaaaaadaeaaahoaaaaaoeiaacaaoeiaafaaaaad
aaaaapiaaaaaffjabcaaoekaaeaaaaaeaaaaapiabbaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiabdaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabeaaoeka
aaaappjaaaaaoeiaafaaaaadacaaapiaaaaaffiaakaaoekaaeaaaaaeacaaapia
ajaaoekaaaaaaaiaacaaoeiaaeaaaaaeacaaapiaalaaoekaaaaakkiaacaaoeia
aeaaaaaeafaaapoaamaaoekaaaaappiaacaaoeiaafaaaaadaaaaapiaaaaaffja
aoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
apaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
afaaaaadaaaaahiaabaaffjabcaamjkaaeaaaaaeaaaaahiabbaamjkaabaaaaja
aaaaoeiaaeaaaaaeaaaaahiabdaamjkaabaakkjaaaaaoeiaaiaaaaadaaaaaiia
aaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadaaaaahiaaaaappia
aaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaadacaaahiaaaaaoeiaabaancia
aeaaaaaeacaaahiaabaamjiaaaaamjiaacaaoeibafaaaaadacaaahiaacaaoeia
abaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoaabaaaaiaafaaaaad
adaaahiaaaaaffjabcaaoekaaeaaaaaeadaaahiabbaaoekaaaaaaajaadaaoeia
aeaaaaaeadaaahiabdaaoekaaaaakkjaadaaoeiaaeaaaaaeadaaahiabeaaoeka
aaaappjaadaaoeiaabaaaaacabaaaioaadaaaaiaabaaaaacacaaaboaaaaaaaia
abaaaaacadaaaboaaaaaffiaabaaaaacacaaacoaacaaffiaabaaaaacadaaacoa
acaakkiaabaaaaacacaaaeoaabaaffiaabaaaaacadaaaeoaabaakkiaabaaaaac
acaaaioaadaaffiaabaaaaacadaaaioaadaakkiappppaaaafdeieefcjaaiaaaa
eaaaabaaceacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaa
abaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaa
adaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaacaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaajgiecaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaadaaaaaaamaaaaaa
agbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaa
adaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
bcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaibcaabaaaadaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaacgajbaaa
acaaaaaadcaaaaakhcaabaaaadaaaaaajgaebaaaacaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaadaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaacaaaaaaakaabaaa
acaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaaaaaaaaaa
dgaaaaaficcabaaaaeaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaadaaaaaa
bkaabaaaacaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaadaaaaaadgaaaaaf
cccabaaaaeaaaaaackaabaaaadaaaaaadgaaaaafeccabaaaaeaaaaaackaabaaa
acaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaaakaabaia
ebaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaajgacbaaaacaaaaaaegakbaaa
acaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
abaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
abaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaa
aaaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaacaaaaaa
aaaaaaahhccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaacaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaagaaaaaaegiocaaaacaaaaaaalaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
oaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
lmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedfigecdhdcinojmelemoidgkfiaiadpjiabaaaaaamibdaaaaaeaaaaaa
daaaaaaalaagaaaaaabcaaaapibcaaaaebgpgodjhiagaaaahiagaaaaaaacpopp
aiagaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaanaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaacgaaahaaakaaaaaaaaaa
acaaaiaaaeaabbaaaaaaaaaaadaaaaaaaeaabfaaaaaaaaaaadaaamaaahaabjaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafcaaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaacaaaajabnaaaakaafaaaaadaaaaacia
acaaaajaboaaaakaafaaaaadaaaaaeiaacaaaajabpaaaakaafaaaaadabaaabia
acaaffjabnaaffkaafaaaaadabaaaciaacaaffjaboaaffkaafaaaaadabaaaeia
acaaffjabpaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabia
acaakkjabnaakkkaafaaaaadabaaaciaacaakkjaboaakkkaafaaaaadabaaaeia
acaakkjabpaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahia
aaaaoeiaafaaaaadaaaaahiaaaaaffjabkaaoekaaeaaaaaeaaaaahiabjaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaahiablaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaahiabmaaoekaaaaappjaaaaaoeiaacaaaaadacaaapiaaaaaffibadaaoeka
afaaaaadadaaapiaabaaffiaacaaoeiaafaaaaadacaaapiaacaaoeiaacaaoeia
acaaaaadaeaaapiaaaaaaaibacaaoekaaeaaaaaeadaaapiaaeaaoeiaabaaaaia
adaaoeiaaeaaaaaeacaaapiaaeaaoeiaaeaaoeiaacaaoeiaacaaaaadaeaaapia
aaaakkibaeaaoekaaeaaaaaeadaaapiaaeaaoeiaabaakkiaadaaoeiaaeaaaaae
acaaapiaaeaaoeiaaeaaoeiaacaaoeiaahaaaaacaeaaabiaacaaaaiaahaaaaac
aeaaaciaacaaffiaahaaaaacaeaaaeiaacaakkiaahaaaaacaeaaaiiaacaappia
abaaaaacafaaabiacaaaaakaaeaaaaaeacaaapiaacaaoeiaafaaoekaafaaaaia
afaaaaadadaaapiaadaaoeiaaeaaoeiaalaaaaadadaaapiaadaaoeiacaaaffka
agaaaaacaeaaabiaacaaaaiaagaaaaacaeaaaciaacaaffiaagaaaaacaeaaaeia
acaakkiaagaaaaacaeaaaiiaacaappiaafaaaaadacaaapiaadaaoeiaaeaaoeia
afaaaaadadaaahiaacaaffiaahaaoekaaeaaaaaeadaaahiaagaaoekaacaaaaia
adaaoeiaaeaaaaaeacaaahiaaiaaoekaacaakkiaadaaoeiaaeaaaaaeacaaahia
ajaaoekaacaappiaacaaoeiaafaaaaadaaaaaiiaabaaffiaabaaffiaaeaaaaae
aaaaaiiaabaaaaiaabaaaaiaaaaappibafaaaaadadaaapiaabaacjiaabaakeia
ajaaaaadaeaaabiaanaaoekaadaaoeiaajaaaaadaeaaaciaaoaaoekaadaaoeia
ajaaaaadaeaaaeiaapaaoekaadaaoeiaaeaaaaaeadaaahiabaaaoekaaaaappia
aeaaoeiaabaaaaacabaaaiiacaaaaakaajaaaaadaeaaabiaakaaoekaabaaoeia
ajaaaaadaeaaaciaalaaoekaabaaoeiaajaaaaadaeaaaeiaamaaoekaabaaoeia
acaaaaadadaaahiaadaaoeiaaeaaoeiaacaaaaadaeaaahoaacaaoeiaadaaoeia
afaaaaadacaaapiaaaaaffjabkaaoekaaeaaaaaeacaaapiabjaaoekaaaaaaaja
acaaoeiaaeaaaaaeacaaapiablaaoekaaaaakkjaacaaoeiaaeaaaaaeacaaapia
bmaaoekaaaaappjaacaaoeiaafaaaaadadaaapiaacaaffiabcaaoekaaeaaaaae
adaaapiabbaaoekaacaaaaiaadaaoeiaaeaaaaaeadaaapiabdaaoekaacaakkia
adaaoeiaaeaaaaaeafaaapoabeaaoekaacaappiaadaaoeiaafaaaaadacaaapia
aaaaffjabgaaoekaaeaaaaaeacaaapiabfaaoekaaaaaaajaacaaoeiaaeaaaaae
acaaapiabhaaoekaaaaakkjaacaaoeiaaeaaaaaeacaaapiabiaaoekaaaaappja
acaaoeiaaeaaaaaeaaaaadmaacaappiaaaaaoekaacaaoeiaabaaaaacaaaaamma
acaaoeiaafaaaaadacaaahiaabaaffjabkaamjkaaeaaaaaeacaaahiabjaamjka
abaaaajaacaaoeiaaeaaaaaeacaaahiablaamjkaabaakkjaacaaoeiaaiaaaaad
aaaaaiiaacaaoeiaacaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadacaaahia
aaaappiaacaaoeiaabaaaaacabaaaboaacaakkiaafaaaaadadaaahiaabaancia
acaaoeiaaeaaaaaeadaaahiaabaamjiaacaamjiaadaaoeibafaaaaadadaaahia
adaaoeiaabaappjaabaaaaacabaaacoaadaaaaiaabaaaaacabaaaeoaabaaaaia
abaaaaacabaaaioaaaaaaaiaabaaaaacacaaaboaacaaaaiaabaaaaacadaaaboa
acaaffiaabaaaaacacaaacoaadaaffiaabaaaaacadaaacoaadaakkiaabaaaaac
acaaaeoaabaaffiaabaaaaacadaaaeoaabaakkiaabaaaaacacaaaioaaaaaffia
abaaaaacadaaaioaaaaakkiappppaaaafdeieefceialaaaaeaaaabaancacaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaa
fjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaad
pccabaaaagaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaabaaaaaajgiecaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgiecaaaadaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaajgiecaaaadaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafbccabaaaacaaaaaackaabaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
bcaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaacgajbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaajgaebaaaabaaaaaajgaebaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
eccabaaaacaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaadaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaadaaaaaadgaaaaaf
bccabaaaadaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaa
aaaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaa
aeaaaaaackaabaaaacaaaaaadgaaaaafeccabaaaadaaaaaabkaabaaaabaaaaaa
dgaaaaaficcabaaaadaaaaaabkaabaaaadaaaaaadgaaaaaficcabaaaaeaaaaaa
ckaabaaaadaaaaaadgaaaaafeccabaaaaeaaaaaackaabaaaabaaaaaadiaaaaah
bcaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
aeaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
acaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
acaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaa
acaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaabaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaa
fgafbaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaa
aeaaaaaafgafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaacaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaia
ebaaaaaaadaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaa
kgakbaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaa
aeaaaaaaegaobaaaafaaaaaaagaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaacaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaa
acaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaacaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaan
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaajaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaa
ajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaiaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaa
akaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaa
egiocaaaacaaaaaaalaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * TANGENT.xyz));
  vec3 tmpvar_9;
  tmpvar_9 = (((tmpvar_6.yzx * tmpvar_8.zxy) - (tmpvar_6.zxy * tmpvar_8.yzx)) * TANGENT.w);
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_8.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = tmpvar_6.x;
  tmpvar_10.w = tmpvar_2.x;
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = tmpvar_6.y;
  tmpvar_11.w = tmpvar_2.y;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_8.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = tmpvar_6.z;
  tmpvar_12.w = tmpvar_2.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  vec3 x2_14;
  vec3 x1_15;
  x1_15.x = dot (unity_SHAr, tmpvar_13);
  x1_15.y = dot (unity_SHAg, tmpvar_13);
  x1_15.z = dot (unity_SHAb, tmpvar_13);
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_14.x = dot (unity_SHBr, tmpvar_16);
  x2_14.y = dot (unity_SHBg, tmpvar_16);
  x2_14.z = dot (unity_SHBb, tmpvar_16);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = ((x2_14 + (unity_SHC.xyz * 
    ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y))
  )) + x1_15);
  xlv_TEXCOORD6 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_10;
  tmpvar_10 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_9 + tmpvar_8)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_7.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_9)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_10)
  ) * 2.0) + ((tmpvar_5 * _LightColor0.xyz) * (
    ((2.0 * (pow (
      max (0.0, dot (tmpvar_8, -((tmpvar_9 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_7.w = ((_LightColor0.w * _SpecColor.w) * tmpvar_10);
  c_2.xyz = mix (unity_FogColor.xyz, (c_2 + c_7).xyz, vec3(clamp (xlv_TEXCOORD6, 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_MainTex_ST]
Vector 17 [unity_FogParams]
Vector 12 [unity_SHAb]
Vector 11 [unity_SHAg]
Vector 10 [unity_SHAr]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_2_0
def c19, 1, 0, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v3, c18, c18.zwzw
dp4 oT1.w, c4, v0
dp4 oT2.w, c5, v0
dp4 oT3.w, c6, v0
mul r0.xyz, v2.y, c8
mad r0.xyz, c7, v2.x, r0
mad r0.xyz, c9, v2.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mad r0.xyz, c16, r0.x, r3
mov r1.w, c19.x
dp4 r2.x, c10, r1
dp4 r2.y, c11, r1
dp4 r2.z, c12, r1
add oT4.xyz, r0, r2
dp4 r0.x, c2, v0
mul r0.y, r0.x, c17.y
mov oPos.z, r0.x
exp oT6.x, -r0.y
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r2.xyz, r0, r1.zxyw
mad r2.xyz, r1.yzxw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.x
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.y
mov oT3.z, r1.z

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0
eefiecedhjmkcmbmddedbgfobfocbabbgphcfbeoabaaaaaakiajaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckmahaaaaeaaaabaa
olabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaaeegiocaaaadaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaadaaaaaaabaaaaaa
bjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaa
anaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
abaaaaaajgiecaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaa
acaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaacaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaacaaaaaa
akiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaacaaaaaa
akiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaacaaaaaa
akiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaacaaaaaa
bkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaacaaaaaa
bkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaacaaaaaa
bkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaaacaaaaaackiacaaa
acaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaaacaaaaaackiacaaa
acaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaaacaaaaaackiacaaa
acaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
abaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaajgaebaaaacaaaaaa
jgaebaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaa
adaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaa
acaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaa
dgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaaadaaaaaa
bkaabaaaaaaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaaaaaaaaadgaaaaaf
eccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaa
adaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaadaaaaaadgaaaaafeccabaaa
aeaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaacaaaaaa
bkaabaaaacaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaajgacbaaa
acaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
cmaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaacaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0_level_9_1
eefiecedbhabhegdbahdbkldahjgkakfhfggphcpabaaaaaapianaaaaaeaaaaaa
daaaaaaahmaeaaaadaamaaaacianaaaaebgpgodjeeaeaaaaeeaeaaaaaaacpopp
oaadaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaanaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaahaaanaaaaaaaaaaadaaabaaabaabeaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbfaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaabiaacaaaajabbaaaakaafaaaaadaaaaaciaacaaaajabcaaaakaafaaaaad
aaaaaeiaacaaaajabdaaaakaafaaaaadabaaabiaacaaffjabbaaffkaafaaaaad
abaaaciaacaaffjabcaaffkaafaaaaadabaaaeiaacaaffjabdaaffkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjabbaakkkaafaaaaad
abaaaciaacaakkjabcaakkkaafaaaaadabaaaeiaacaakkjabdaakkkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabia
abaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaad
acaaapiaabaacjiaabaakeiaajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaad
adaaaciaagaaoekaacaaoeiaajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaae
aaaaahiaaiaaoekaaaaaaaiaadaaoeiaabaaaaacabaaaiiabfaaaakaajaaaaad
acaaabiaacaaoekaabaaoeiaajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaad
acaaaeiaaeaaoekaabaaoeiaacaaaaadaeaaahoaaaaaoeiaacaaoeiaafaaaaad
aaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoeka
aaaappjaaaaaoeiaafaaaaadabaaaiiaaaaakkiabeaaffkaaoaaaaacaaaaaeoa
abaappibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaafaaaaadaaaaahiaabaaffjaaoaamjkaaeaaaaaeaaaaahiaanaamjka
abaaaajaaaaaoeiaaeaaaaaeaaaaahiaapaamjkaabaakkjaaaaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadaaaaahia
aaaappiaaaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaadacaaahiaaaaaoeia
abaanciaaeaaaaaeacaaahiaabaamjiaaaaamjiaacaaoeibafaaaaadacaaahia
acaaoeiaabaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoaabaaaaia
afaaaaadadaaahiaaaaaffjaaoaaoekaaeaaaaaeadaaahiaanaaoekaaaaaaaja
adaaoeiaaeaaaaaeadaaahiaapaaoekaaaaakkjaadaaoeiaaeaaaaaeadaaahia
baaaoekaaaaappjaadaaoeiaabaaaaacabaaaioaadaaaaiaabaaaaacacaaaboa
aaaaaaiaabaaaaacadaaaboaaaaaffiaabaaaaacacaaacoaacaaffiaabaaaaac
adaaacoaacaakkiaabaaaaacacaaaeoaabaaffiaabaaaaacadaaaeoaabaakkia
abaaaaacacaaaioaadaaffiaabaaaaacadaaaioaadaakkiappppaaaafdeieefc
kmahaaaaeaaaabaaolabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaae
egiocaaaadaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
adaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaa
ogikcaaaaaaaaaaaanaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaacaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaacaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaacaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
jgaebaaaacaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaa
acaaaaaaakaabaaaadaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaa
dgaaaaafeccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaaadaaaaaa
akaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaf
iccabaaaadaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaa
adaaaaaabkaabaaaadaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaadaaaaaa
dgaaaaafeccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaf
icaabaaaacaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaacaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
oaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_DynamicLightmapST;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_5.xyz * gl_Normal.y)
  ) + (v_6.xyz * gl_Normal.z)));
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * TANGENT.xyz));
  vec3 tmpvar_10;
  tmpvar_10 = (((tmpvar_7.yzx * tmpvar_9.zxy) - (tmpvar_7.zxy * tmpvar_9.yzx)) * TANGENT.w);
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.y = tmpvar_10.x;
  tmpvar_11.z = tmpvar_7.x;
  tmpvar_11.w = tmpvar_3.x;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_9.y;
  tmpvar_12.y = tmpvar_10.y;
  tmpvar_12.z = tmpvar_7.y;
  tmpvar_12.w = tmpvar_3.y;
  vec4 tmpvar_13;
  tmpvar_13.x = tmpvar_9.z;
  tmpvar_13.y = tmpvar_10.z;
  tmpvar_13.z = tmpvar_7.z;
  tmpvar_13.w = tmpvar_3.z;
  tmpvar_1.zw = ((gl_MultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD6 = tmpvar_2.z;
  xlv_TEXCOORD7 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D unity_DynamicLightmap;
uniform vec4 unity_DynamicLightmap_HDR;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_10;
  tmpvar_10 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_9 + tmpvar_8)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_7.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_9)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_10)
  ) * 2.0) + ((tmpvar_5 * _LightColor0.xyz) * (
    ((2.0 * (pow (
      max (0.0, dot (tmpvar_8, -((tmpvar_9 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_7.w = ((_LightColor0.w * _SpecColor.w) * tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = (c_2 + c_7);
  c_2.w = tmpvar_11.w;
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD7.zw);
  c_2.xyz = (tmpvar_11.xyz + (tmpvar_5 * pow (
    ((unity_DynamicLightmap_HDR.x * tmpvar_12.w) * tmpvar_12.xyz)
  , unity_DynamicLightmap_HDR.yyy)));
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD6))
  ), 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_MainTex_ST]
Vector 10 [unity_DynamicLightmapST]
"vs_3_0
def c12, 0, 0, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord2 v4
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord6 o6.x
dcl_texcoord7 o7
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c11, c11.zwzw
dp4 o2.w, c4, v0
dp4 o3.w, c5, v0
dp4 o4.w, c6, v0
mad o7.zw, v4.xyxy, c10.xyxy, c10
dp4 r0.x, c2, v0
mov o0.z, r0.x
mov o6.x, r0.x
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x
mov o5.xyz, c12.x
mov o7.xy, c12.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityLightmaps" 32
Vector 16 [unity_DynamicLightmapST]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityLightmaps" 2
"vs_4_0
eefiecededibpaabnhcjpcpjiaegfjjagglcfapoabaaaaaajiaiaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapadaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcieagaaaaeaaaabaakbabaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaae
egiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaa
dgaaaaaficcabaaaacaaaaaaakaabaaaadaaaaaadgaaaaafbccabaaaacaaaaaa
ckaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaaf
eccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaa
abaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaa
adaaaaaabkaabaaaadaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaadaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadgaaaaaihccabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadcaaaaalmccabaaaagaaaaaaagbebaaaafaaaaaaagiecaaa
acaaaaaaabaaaaaakgiocaaaacaaaaaaabaaaaaadgaaaaaidccabaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * TANGENT.xyz));
  vec3 tmpvar_9;
  tmpvar_9 = (((tmpvar_6.yzx * tmpvar_8.zxy) - (tmpvar_6.zxy * tmpvar_8.yzx)) * TANGENT.w);
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_8.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = tmpvar_6.x;
  tmpvar_10.w = tmpvar_2.x;
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = tmpvar_6.y;
  tmpvar_11.w = tmpvar_2.y;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_8.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = tmpvar_6.z;
  tmpvar_12.w = tmpvar_2.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  vec3 x2_14;
  vec3 x1_15;
  x1_15.x = dot (unity_SHAr, tmpvar_13);
  x1_15.y = dot (unity_SHAg, tmpvar_13);
  x1_15.z = dot (unity_SHAb, tmpvar_13);
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_14.x = dot (unity_SHBr, tmpvar_16);
  x2_14.y = dot (unity_SHBg, tmpvar_16);
  x2_14.z = dot (unity_SHBb, tmpvar_16);
  vec4 o_17;
  vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_1 * 0.5);
  vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = ((x2_14 + (unity_SHC.xyz * 
    ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y))
  )) + x1_15);
  xlv_TEXCOORD5 = o_17;
  xlv_TEXCOORD6 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_8;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_11;
  tmpvar_11 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_10 + tmpvar_9)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_8.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_10)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_11)
  ) * (tmpvar_7.x * 2.0)) + ((tmpvar_5 * _LightColor0.xyz) * (
    (((tmpvar_7.x * 2.0) * (pow (
      max (0.0, dot (tmpvar_9, -((tmpvar_10 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_8.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_11) * tmpvar_7.x);
  c_2.xyz = mix (unity_FogColor.xyz, (c_2 + c_8).xyz, vec3(clamp (xlv_TEXCOORD6, 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 20 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 19 [unity_FogParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c21, 1, 0.5, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
mad oT0.xy, v3, c20, c20.zwzw
dp4 oT1.w, c4, v0
dp4 oT2.w, c5, v0
dp4 oT3.w, c6, v0
mul r0.xyz, v2.y, c8
mad r0.xyz, c7, v2.x, r0
mad r0.xyz, c9, v2.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c15, r2
dp4 r3.y, c16, r2
dp4 r3.z, c17, r2
mad r0.xyz, c18, r0.x, r3
mov r1.w, c21.x
dp4 r2.x, c12, r1
dp4 r2.y, c13, r1
dp4 r2.z, c14, r1
add oT4.xyz, r0, r2
dp4 r0.y, c1, v0
mul r1.w, r0.y, c10.x
mul r2.w, r1.w, c21.y
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r2.xz, r0.xyww, c21.y
mad oT5.xy, r2.z, c11.zwzw, r2.xwzw
dp4 r0.z, c2, v0
mul r1.w, r0.z, c19.y
exp oT6.x, -r1.w
mov oPos, r0
mov oT5.zw, r0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r2.xyz, r0, r1.zxyw
mad r2.xyz, r1.yzxw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.x
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.y
mov oT3.z, r1.z

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0
eefiecedkaoiolidkmedimimbadmbliddfjlnefnabaaaaaafeakaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefceaaiaaaaeaaaabaabaacaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafjaaaaae
egiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
ckaabaaaaaaaaaaabkiacaaaaeaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaabaaaaaajgiecaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaacaaaaaajgiecaaaadaaaaaaamaaaaaaagbabaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaajgiecaaaadaaaaaa
aoaaaaaakgbkbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaibcaabaaaadaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaa
diaaaaaibcaabaaaaeaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaaeaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaaeaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaadiaaaaai
bcaabaaaaeaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaaeaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaaeaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaaagaabaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaacaaaaaacgajbaaaadaaaaaa
dcaaaaakhcaabaaaaeaaaaaajgaebaaaadaaaaaajgaebaaaacaaaaaaegacbaia
ebaaaaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaapgbpbaaa
abaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaaeaaaaaadgaaaaafbccabaaa
acaaaaaackaabaaaacaaaaaadgaaaaafeccabaaaacaaaaaaakaabaaaadaaaaaa
dgaaaaafbccabaaaadaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaaaeaaaaaa
bkaabaaaacaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaaabaaaaaadgaaaaaf
iccabaaaaeaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaabkaabaaa
adaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaaeaaaaaadgaaaaafcccabaaa
aeaaaaaackaabaaaaeaaaaaadgaaaaafeccabaaaaeaaaaaackaabaaaadaaaaaa
diaaaaahbcaabaaaabaaaaaabkaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaak
bcaabaaaabaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaadaaaaaaegakbaaaadaaaaaa
bbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaa
egacbaaaaeaaaaaadgaaaaaficaabaaaadaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaadaaaaaabbaaaaai
ccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaadaaaaaabbaaaaai
ecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaadaaaaaaaaaaaaah
hccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_DynamicLightmapST;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_5.xyz * gl_Normal.y)
  ) + (v_6.xyz * gl_Normal.z)));
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * TANGENT.xyz));
  vec3 tmpvar_10;
  tmpvar_10 = (((tmpvar_7.yzx * tmpvar_9.zxy) - (tmpvar_7.zxy * tmpvar_9.yzx)) * TANGENT.w);
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.y = tmpvar_10.x;
  tmpvar_11.z = tmpvar_7.x;
  tmpvar_11.w = tmpvar_3.x;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_9.y;
  tmpvar_12.y = tmpvar_10.y;
  tmpvar_12.z = tmpvar_7.y;
  tmpvar_12.w = tmpvar_3.y;
  vec4 tmpvar_13;
  tmpvar_13.x = tmpvar_9.z;
  tmpvar_13.y = tmpvar_10.z;
  tmpvar_13.z = tmpvar_7.z;
  tmpvar_13.w = tmpvar_3.z;
  tmpvar_1.zw = ((gl_MultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
  vec4 o_14;
  vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_2 * 0.5);
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD5 = o_14;
  xlv_TEXCOORD6 = tmpvar_2.z;
  xlv_TEXCOORD7 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D unity_DynamicLightmap;
uniform vec4 unity_DynamicLightmap_HDR;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_8;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_11;
  tmpvar_11 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_10 + tmpvar_9)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_8.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_10)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_11)
  ) * (tmpvar_7.x * 2.0)) + ((tmpvar_5 * _LightColor0.xyz) * (
    (((tmpvar_7.x * 2.0) * (pow (
      max (0.0, dot (tmpvar_9, -((tmpvar_10 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_8.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_11) * tmpvar_7.x);
  vec4 tmpvar_12;
  tmpvar_12 = (c_2 + c_8);
  c_2.w = tmpvar_12.w;
  vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD7.zw);
  c_2.xyz = (tmpvar_12.xyz + (tmpvar_5 * pow (
    ((unity_DynamicLightmap_HDR.x * tmpvar_13.w) * tmpvar_13.xyz)
  , unity_DynamicLightmap_HDR.yyy)));
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD6))
  ), 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 12 [unity_DynamicLightmapST]
"vs_3_0
def c14, 0.5, 0, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord2 v4
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord6 o7.x
dcl_texcoord7 o8
mad o1.xy, v3, c13, c13.zwzw
dp4 o2.w, c4, v0
dp4 o3.w, c5, v0
dp4 o4.w, c6, v0
mad o8.zw, v4.xyxy, c12.xyxy, c12
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c14.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c14.x
mad o6.xy, r1.z, c11.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o6.zw, r0
mov o7.x, r0.z
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x
mov o5.xyz, c14.y
mov o8.xy, c14.y

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityLightmaps" 32
Vector 16 [unity_DynamicLightmapST]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityLightmaps" 3
"vs_4_0
eefiecedmocmbgblookmkdiiopaomhccjemajmehabaaaaaagaajaaaaadaaaaaa
cmaaaaaaceabaaaaceacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapadaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaomaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcdeahaaaaeaaaabaamnabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
bdaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafeccabaaaabaaaaaa
ckaabaaaaaaaaaaadgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaa
aaaaaaaaanaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaa
acaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaa
acaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaa
acaaaaaabcaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaa
acaaaaaabaaaaaaadiaaaaaiecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaa
acaaaaaabbaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaa
acaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaackiacaaaacaaaaaa
baaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaaacaaaaaackiacaaaacaaaaaa
bbaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaackiacaaaacaaaaaa
bcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaafgbfbaaaabaaaaaajgiecaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaacaaaaaajgiecaaaacaaaaaaamaaaaaaagbabaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaajgiecaaaacaaaaaaaoaaaaaa
kgbkbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
adaaaaaacgajbaaaabaaaaaajgaebaaaacaaaaaaegacbaiaebaaaaaaadaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaaf
cccabaaaacaaaaaaakaabaaaadaaaaaadiaaaaaihcaabaaaaeaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaa
aeaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaeaaaaaa
dcaaaaakhcaabaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaeaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaaeaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaacaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
abaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaacaaaaaa
dgaaaaaficcabaaaadaaaaaabkaabaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaa
ckaabaaaaeaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaadaaaaaadgaaaaaf
cccabaaaaeaaaaaackaabaaaadaaaaaadgaaaaaihccabaaaafaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakfcaabaaaaaaaaaaaagadbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaadiaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaadpaaaaaaahdccabaaaagaaaaaa
kgakbaaaaaaaaaaamgaabaaaaaaaaaaadcaaaaalmccabaaaahaaaaaaagbebaaa
afaaaaaaagiecaaaadaaaaaaabaaaaaakgiocaaaadaaaaaaabaaaaaadgaaaaai
dccabaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * TANGENT.xyz));
  vec3 tmpvar_9;
  tmpvar_9 = (((tmpvar_6.yzx * tmpvar_8.zxy) - (tmpvar_6.zxy * tmpvar_8.yzx)) * TANGENT.w);
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_8.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = tmpvar_6.x;
  tmpvar_10.w = tmpvar_2.x;
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = tmpvar_6.y;
  tmpvar_11.w = tmpvar_2.y;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_8.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = tmpvar_6.z;
  tmpvar_12.w = tmpvar_2.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  vec3 x2_14;
  vec3 x1_15;
  x1_15.x = dot (unity_SHAr, tmpvar_13);
  x1_15.y = dot (unity_SHAg, tmpvar_13);
  x1_15.z = dot (unity_SHAb, tmpvar_13);
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_14.x = dot (unity_SHBr, tmpvar_16);
  x2_14.y = dot (unity_SHBg, tmpvar_16);
  x2_14.z = dot (unity_SHBb, tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_2.x);
  vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_2.y);
  vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_2.z);
  vec4 tmpvar_20;
  tmpvar_20 = (((tmpvar_17 * tmpvar_17) + (tmpvar_18 * tmpvar_18)) + (tmpvar_19 * tmpvar_19));
  vec4 tmpvar_21;
  tmpvar_21 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_17 * tmpvar_6.x) + (tmpvar_18 * tmpvar_6.y)) + (tmpvar_19 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_20)
  )) * (1.0/((1.0 + 
    (tmpvar_20 * unity_4LightAtten0)
  ))));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = (((x2_14 + 
    (unity_SHC.xyz * ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y)))
  ) + x1_15) + ((
    ((unity_LightColor[0].xyz * tmpvar_21.x) + (unity_LightColor[1].xyz * tmpvar_21.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_21.z)
  ) + (unity_LightColor[3].xyz * tmpvar_21.w)));
  xlv_TEXCOORD6 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_10;
  tmpvar_10 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_9 + tmpvar_8)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_7.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_9)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_10)
  ) * 2.0) + ((tmpvar_5 * _LightColor0.xyz) * (
    ((2.0 * (pow (
      max (0.0, dot (tmpvar_8, -((tmpvar_9 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_7.w = ((_LightColor0.w * _SpecColor.w) * tmpvar_10);
  c_2.xyz = mix (unity_FogColor.xyz, (c_2 + c_7).xyz, vec3(clamp (xlv_TEXCOORD6, 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 26 [_MainTex_ST]
Vector 17 [unity_4LightAtten0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 25 [unity_FogParams]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 20 [unity_SHAb]
Vector 19 [unity_SHAg]
Vector 18 [unity_SHAr]
Vector 23 [unity_SHBb]
Vector 22 [unity_SHBg]
Vector 21 [unity_SHBr]
Vector 24 [unity_SHC]
"vs_2_0
def c27, 1, 0, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c4, v0
dp4 oPos.y, c5, v0
dp4 oPos.w, c7, v0
mad oT0.xy, v3, c26, c26.zwzw
dp4 r0.x, c9, v0
add r1, -r0.x, c15
mov oT2.w, r0.x
mul r0, r1, r1
dp4 r2.x, c8, v0
add r3, -r2.x, c14
mov oT1.w, r2.x
mad r0, r3, r3, r0
dp4 r2.x, c10, v0
add r4, -r2.x, c16
mov oT3.w, r2.x
mad r0, r4, r4, r0
rsq r2.x, r0.x
rsq r2.y, r0.y
rsq r2.z, r0.z
rsq r2.w, r0.w
mov r5.x, c27.x
mad r0, r0, c17, r5.x
mul r5.xyz, v2.y, c12
mad r5.xyz, c11, v2.x, r5
mad r5.xyz, c13, v2.z, r5
nrm r6.xyz, r5
mul r1, r1, r6.y
mad r1, r3, r6.x, r1
mad r1, r4, r6.z, r1
mul r1, r2, r1
max r1, r1, c27.y
rcp r2.x, r0.x
rcp r2.y, r0.y
rcp r2.z, r0.z
rcp r2.w, r0.w
mul r0, r1, r2
mul r1.xyz, r0.y, c1
mad r1.xyz, c0, r0.x, r1
mad r0.xyz, c2, r0.z, r1
mad r0.xyz, c3, r0.w, r0
mul r0.w, r6.y, r6.y
mad r0.w, r6.x, r6.x, -r0.w
mul r1, r6.yzzx, r6.xyzz
dp4 r2.x, c21, r1
dp4 r2.y, c22, r1
dp4 r2.z, c23, r1
mad r1.xyz, c24, r0.w, r2
mov r6.w, c27.x
dp4 r2.x, c18, r6
dp4 r2.y, c19, r6
dp4 r2.z, c20, r6
add r1.xyz, r1, r2
add oT4.xyz, r0, r1
dp4 r0.x, c6, v0
mul r0.y, r0.x, c25.y
mov oPos.z, r0.x
exp oT6.x, -r0.y
dp3 r0.z, c8, v1
dp3 r0.x, c9, v1
dp3 r0.y, c10, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, r0, r6.zxyw
mad r1.xyz, r6.yzxw, r0.yzxw, -r1
mul r1.xyz, r1, v1.w
mov oT1.y, r1.x
mov oT1.z, r6.x
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r1.y
mov oT3.y, r1.z
mov oT2.z, r6.y
mov oT3.z, r6.z

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0
eefiecedieackooecdmahbogdpbdjdophafkooljabaaaaaagaamaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcgeakaaaaeaaaabaa
jjacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaaeegiocaaaadaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaadaaaaaaabaaaaaa
bjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaa
anaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaabaaaaaajgiecaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaajgiecaaaacaaaaaaamaaaaaaagbabaaa
abaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaajgiecaaaacaaaaaa
aoaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafbccabaaaacaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaacgajbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaa
jgaebaaaabaaaaaajgaebaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaa
acaaaaaaakaabaaaacaaaaaadgaaaaafeccabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficcabaaa
acaaaaaaakaabaaaadaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaaaaaaaaa
dgaaaaafbccabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaafcccabaaaadaaaaaa
bkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadgaaaaaf
eccabaaaadaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaa
adaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaadaaaaaadgaaaaafeccabaaa
aeaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
abaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
cmaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadgaaaaaficaabaaaabaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaajpcaabaaaacaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaa
abaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
aaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaaabaaaaaa
acaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaa
abaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaa
abaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaa
kgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaa
afaaaaaaegaobaaaafaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaacaaaaaa
egaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaaeeaaaaafpcaabaaa
adaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaa
egiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
aoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
egaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
adaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
abaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaaagaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaahhccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0_level_9_1
eefieceddbpljpblcmkaddljemepjaapiamidnjlabaaaaaagibcaaaaaeaaaaaa
daaaaaaadeagaaaakabaaaaajibbaaaaebgpgodjpmafaaaapmafaaaaaaacpopp
imafaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaanaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaacgaaahaaakaaaaaaaaaa
acaaaaaaaeaabbaaaaaaaaaaacaaamaaahaabfaaaaaaaaaaadaaabaaabaabmaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbnaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaacaaaajabjaaaakaafaaaaadaaaaacia
acaaaajabkaaaakaafaaaaadaaaaaeiaacaaaajablaaaakaafaaaaadabaaabia
acaaffjabjaaffkaafaaaaadabaaaciaacaaffjabkaaffkaafaaaaadabaaaeia
acaaffjablaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabia
acaakkjabjaakkkaafaaaaadabaaaciaacaakkjabkaakkkaafaaaaadabaaaeia
acaakkjablaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahia
aaaaoeiaafaaaaadaaaaahiaaaaaffjabgaaoekaaeaaaaaeaaaaahiabfaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaahiabhaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaahiabiaaoekaaaaappjaaaaaoeiaacaaaaadacaaapiaaaaaffibadaaoeka
afaaaaadadaaapiaabaaffiaacaaoeiaafaaaaadacaaapiaacaaoeiaacaaoeia
acaaaaadaeaaapiaaaaaaaibacaaoekaaeaaaaaeadaaapiaaeaaoeiaabaaaaia
adaaoeiaaeaaaaaeacaaapiaaeaaoeiaaeaaoeiaacaaoeiaacaaaaadaeaaapia
aaaakkibaeaaoekaaeaaaaaeadaaapiaaeaaoeiaabaakkiaadaaoeiaaeaaaaae
acaaapiaaeaaoeiaaeaaoeiaacaaoeiaahaaaaacaeaaabiaacaaaaiaahaaaaac
aeaaaciaacaaffiaahaaaaacaeaaaeiaacaakkiaahaaaaacaeaaaiiaacaappia
abaaaaacafaaabiabnaaaakaaeaaaaaeacaaapiaacaaoeiaafaaoekaafaaaaia
afaaaaadadaaapiaadaaoeiaaeaaoeiaalaaaaadadaaapiaadaaoeiabnaaffka
agaaaaacaeaaabiaacaaaaiaagaaaaacaeaaaciaacaaffiaagaaaaacaeaaaeia
acaakkiaagaaaaacaeaaaiiaacaappiaafaaaaadacaaapiaadaaoeiaaeaaoeia
afaaaaadadaaahiaacaaffiaahaaoekaaeaaaaaeadaaahiaagaaoekaacaaaaia
adaaoeiaaeaaaaaeacaaahiaaiaaoekaacaakkiaadaaoeiaaeaaaaaeacaaahia
ajaaoekaacaappiaacaaoeiaafaaaaadaaaaaiiaabaaffiaabaaffiaaeaaaaae
aaaaaiiaabaaaaiaabaaaaiaaaaappibafaaaaadadaaapiaabaacjiaabaakeia
ajaaaaadaeaaabiaanaaoekaadaaoeiaajaaaaadaeaaaciaaoaaoekaadaaoeia
ajaaaaadaeaaaeiaapaaoekaadaaoeiaaeaaaaaeadaaahiabaaaoekaaaaappia
aeaaoeiaabaaaaacabaaaiiabnaaaakaajaaaaadaeaaabiaakaaoekaabaaoeia
ajaaaaadaeaaaciaalaaoekaabaaoeiaajaaaaadaeaaaeiaamaaoekaabaaoeia
acaaaaadadaaahiaadaaoeiaaeaaoeiaacaaaaadaeaaahoaacaaoeiaadaaoeia
afaaaaadacaaapiaaaaaffjabcaaoekaaeaaaaaeacaaapiabbaaoekaaaaaaaja
acaaoeiaaeaaaaaeacaaapiabdaaoekaaaaakkjaacaaoeiaaeaaaaaeacaaapia
beaaoekaaaaappjaacaaoeiaafaaaaadaaaaaiiaacaakkiabmaaffkaaoaaaaac
aaaaaeoaaaaappibaeaaaaaeaaaaadmaacaappiaaaaaoekaacaaoeiaabaaaaac
aaaaammaacaaoeiaafaaaaadacaaahiaabaaffjabgaamjkaaeaaaaaeacaaahia
bfaamjkaabaaaajaacaaoeiaaeaaaaaeacaaahiabhaamjkaabaakkjaacaaoeia
aiaaaaadaaaaaiiaacaaoeiaacaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaad
acaaahiaaaaappiaacaaoeiaabaaaaacabaaaboaacaakkiaafaaaaadadaaahia
abaanciaacaaoeiaaeaaaaaeadaaahiaabaamjiaacaamjiaadaaoeibafaaaaad
adaaahiaadaaoeiaabaappjaabaaaaacabaaacoaadaaaaiaabaaaaacabaaaeoa
abaaaaiaabaaaaacabaaaioaaaaaaaiaabaaaaacacaaaboaacaaaaiaabaaaaac
adaaaboaacaaffiaabaaaaacacaaacoaadaaffiaabaaaaacadaaacoaadaakkia
abaaaaacacaaaeoaabaaffiaabaaaaacadaaaeoaabaakkiaabaaaaacacaaaioa
aaaaffiaabaaaaacadaaaioaaaaakkiappppaaaafdeieefcgeakaaaaeaaaabaa
jjacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaaeegiocaaaadaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaadaaaaaaabaaaaaa
bjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaa
anaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaabaaaaaajgiecaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaajgiecaaaacaaaaaaamaaaaaaagbabaaa
abaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaajgiecaaaacaaaaaa
aoaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafbccabaaaacaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaacgajbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaa
jgaebaaaabaaaaaajgaebaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaa
acaaaaaaakaabaaaacaaaaaadgaaaaafeccabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficcabaaa
acaaaaaaakaabaaaadaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaaaaaaaaa
dgaaaaafbccabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaafcccabaaaadaaaaaa
bkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadgaaaaaf
eccabaaaadaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaa
adaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaadaaaaaadgaaaaafeccabaaa
aeaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
abaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
cmaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadgaaaaaficaabaaaabaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaajpcaabaaaacaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaa
abaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
aaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaaabaaaaaa
acaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaa
abaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaa
abaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaa
kgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaa
afaaaaaaegaobaaaafaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaacaaaaaa
egaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaaeeaaaaafpcaabaaa
adaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaa
egiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
aoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
egaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
adaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
abaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaaagaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaahhccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaagaaaaaa
aaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_DynamicLightmapST;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_5.xyz * gl_Normal.y)
  ) + (v_6.xyz * gl_Normal.z)));
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * TANGENT.xyz));
  vec3 tmpvar_10;
  tmpvar_10 = (((tmpvar_7.yzx * tmpvar_9.zxy) - (tmpvar_7.zxy * tmpvar_9.yzx)) * TANGENT.w);
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.y = tmpvar_10.x;
  tmpvar_11.z = tmpvar_7.x;
  tmpvar_11.w = tmpvar_3.x;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_9.y;
  tmpvar_12.y = tmpvar_10.y;
  tmpvar_12.z = tmpvar_7.y;
  tmpvar_12.w = tmpvar_3.y;
  vec4 tmpvar_13;
  tmpvar_13.x = tmpvar_9.z;
  tmpvar_13.y = tmpvar_10.z;
  tmpvar_13.z = tmpvar_7.z;
  tmpvar_13.w = tmpvar_3.z;
  tmpvar_1.zw = ((gl_MultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
  vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - tmpvar_3.x);
  vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - tmpvar_3.y);
  vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - tmpvar_3.z);
  vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * tmpvar_7.x) + (tmpvar_15 * tmpvar_7.y)) + (tmpvar_16 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  xlv_TEXCOORD6 = tmpvar_2.z;
  xlv_TEXCOORD7 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D unity_DynamicLightmap;
uniform vec4 unity_DynamicLightmap_HDR;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_10;
  tmpvar_10 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_9 + tmpvar_8)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_7.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_9)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_10)
  ) * 2.0) + ((tmpvar_5 * _LightColor0.xyz) * (
    ((2.0 * (pow (
      max (0.0, dot (tmpvar_8, -((tmpvar_9 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_7.w = ((_LightColor0.w * _SpecColor.w) * tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = (c_2 + c_7);
  c_2.w = tmpvar_11.w;
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD7.zw);
  c_2.xyz = (tmpvar_11.xyz + (tmpvar_5 * pow (
    ((unity_DynamicLightmap_HDR.x * tmpvar_12.w) * tmpvar_12.xyz)
  , unity_DynamicLightmap_HDR.yyy)));
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD6))
  ), 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 19 [_MainTex_ST]
Vector 17 [unity_4LightAtten0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 18 [unity_DynamicLightmapST]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
"vs_3_0
def c20, 0, 1, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord2 v4
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord6 o6.x
dcl_texcoord7 o7
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.w, c7, v0
mad o1.xy, v3, c19, c19.zwzw
mad o7.zw, v4.xyxy, c18.xyxy, c18
dp4 r0.x, c8, v0
add r1, -r0.x, c14
mov o2.w, r0.x
dp4 r0.x, c9, v0
add r2, -r0.x, c15
mov o3.w, r0.x
mul r0.xyz, c12.zxyw, v2.y
mad r0.xyz, c11.zxyw, v2.x, r0
mad r0.xyz, c13.zxyw, v2.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mul r3, r0.z, r2
mul r2, r2, r2
mad r2, r1, r1, r2
mad r1, r1, r0.y, r3
dp4 r0.w, c10, v0
add r3, -r0.w, c16
mov o4.zw, r0.xyxw
mad r1, r3, r0.x, r1
mad r2, r3, r3, r2
rsq r3.x, r2.x
rsq r3.y, r2.y
rsq r3.z, r2.z
rsq r3.w, r2.w
mov r4.y, c20.y
mad r2, r2, c17, r4.y
mul r1, r1, r3
max r1, r1, c20.x
rcp r3.x, r2.x
rcp r3.y, r2.y
rcp r3.z, r2.z
rcp r3.w, r2.w
mul r1, r1, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad o5.xyz, c3, r1.w, r1
dp4 r0.w, c6, v0
mov o0.z, r0.w
mov o6.x, r0.w
dp3 r1.z, c8, v1
dp3 r1.x, c9, v1
dp3 r1.y, c10, v1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mov o2.x, r1.z
mul r2.xyz, r0, r1
mad r2.xyz, r0.zxyw, r1.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r0.y
mov o3.x, r1.x
mov o4.x, r1.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r0.z
mov o7.xy, c20.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityLightmaps" 32
Vector 16 [unity_DynamicLightmapST]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityLightmaps" 3
"vs_4_0
eefiecedlhifgbkndommimcldjpeinfmfhmhjcmlabaaaaaacealaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapadaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcbaajaaaaeaaaabaaeeacaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaakaaaaaafjaaaaae
egiocaaaacaaaaaabdaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
afaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafeccabaaaabaaaaaackaabaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
anaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaacaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaacaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaabaaaaaajgiecaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaacaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaajgiecaaaacaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaa
jgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaa
acaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadgaaaaafbccabaaa
acaaaaaackaabaaaabaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaak
hcaabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
adaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaadaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafeccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafcccabaaaadaaaaaa
bkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadgaaaaaf
iccabaaaadaaaaaabkaabaaaadaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaadaaaaaaaaaaaaajpcaabaaa
abaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaah
pcaabaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaaaaaaaaajpcaabaaaaeaaaaaa
agaabaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaa
adaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaaj
pcaabaaaacaaaaaaegaobaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaaaaaaaaaegaobaaaadaaaaaaagaabaaaaaaaaaaaegaobaaa
acaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaa
egaobaaaabaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaa
adaaaaaaegaobaaaabaaaaaaeeaaaaafpcaabaaaacaaaaaaegaobaaaabaaaaaa
dcaaaaanpcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaabaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaabaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadeaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaa
ajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalmccabaaaagaaaaaa
agbebaaaafaaaaaaagiecaaaadaaaaaaabaaaaaakgiocaaaadaaaaaaabaaaaaa
dgaaaaaidccabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * TANGENT.xyz));
  vec3 tmpvar_9;
  tmpvar_9 = (((tmpvar_6.yzx * tmpvar_8.zxy) - (tmpvar_6.zxy * tmpvar_8.yzx)) * TANGENT.w);
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_8.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = tmpvar_6.x;
  tmpvar_10.w = tmpvar_2.x;
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = tmpvar_6.y;
  tmpvar_11.w = tmpvar_2.y;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_8.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = tmpvar_6.z;
  tmpvar_12.w = tmpvar_2.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  vec3 x2_14;
  vec3 x1_15;
  x1_15.x = dot (unity_SHAr, tmpvar_13);
  x1_15.y = dot (unity_SHAg, tmpvar_13);
  x1_15.z = dot (unity_SHAb, tmpvar_13);
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_14.x = dot (unity_SHBr, tmpvar_16);
  x2_14.y = dot (unity_SHBg, tmpvar_16);
  x2_14.z = dot (unity_SHBb, tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_2.x);
  vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_2.y);
  vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_2.z);
  vec4 tmpvar_20;
  tmpvar_20 = (((tmpvar_17 * tmpvar_17) + (tmpvar_18 * tmpvar_18)) + (tmpvar_19 * tmpvar_19));
  vec4 tmpvar_21;
  tmpvar_21 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_17 * tmpvar_6.x) + (tmpvar_18 * tmpvar_6.y)) + (tmpvar_19 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_20)
  )) * (1.0/((1.0 + 
    (tmpvar_20 * unity_4LightAtten0)
  ))));
  vec4 o_22;
  vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_1 * 0.5);
  vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = (((x2_14 + 
    (unity_SHC.xyz * ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y)))
  ) + x1_15) + ((
    ((unity_LightColor[0].xyz * tmpvar_21.x) + (unity_LightColor[1].xyz * tmpvar_21.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_21.z)
  ) + (unity_LightColor[3].xyz * tmpvar_21.w)));
  xlv_TEXCOORD5 = o_22;
  xlv_TEXCOORD6 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_8;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_11;
  tmpvar_11 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_10 + tmpvar_9)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_8.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_10)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_11)
  ) * (tmpvar_7.x * 2.0)) + ((tmpvar_5 * _LightColor0.xyz) * (
    (((tmpvar_7.x * 2.0) * (pow (
      max (0.0, dot (tmpvar_9, -((tmpvar_10 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_8.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_11) * tmpvar_7.x);
  c_2.xyz = mix (unity_FogColor.xyz, (c_2 + c_8).xyz, vec3(clamp (xlv_TEXCOORD6, 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 28 [_MainTex_ST]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 19 [unity_4LightAtten0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 27 [unity_FogParams]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 22 [unity_SHAb]
Vector 21 [unity_SHAg]
Vector 20 [unity_SHAr]
Vector 25 [unity_SHBb]
Vector 24 [unity_SHBg]
Vector 23 [unity_SHBr]
Vector 26 [unity_SHC]
"vs_2_0
def c29, 1, 0, 0.5, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
mad oT0.xy, v3, c28, c28.zwzw
dp4 r0.x, c9, v0
add r1, -r0.x, c17
mov oT2.w, r0.x
mul r0, r1, r1
dp4 r2.x, c8, v0
add r3, -r2.x, c16
mov oT1.w, r2.x
mad r0, r3, r3, r0
dp4 r2.x, c10, v0
add r4, -r2.x, c18
mov oT3.w, r2.x
mad r0, r4, r4, r0
rsq r2.x, r0.x
rsq r2.y, r0.y
rsq r2.z, r0.z
rsq r2.w, r0.w
mov r5.x, c29.x
mad r0, r0, c19, r5.x
mul r5.xyz, v2.y, c12
mad r5.xyz, c11, v2.x, r5
mad r5.xyz, c13, v2.z, r5
nrm r6.xyz, r5
mul r1, r1, r6.y
mad r1, r3, r6.x, r1
mad r1, r4, r6.z, r1
mul r1, r2, r1
max r1, r1, c29.y
rcp r2.x, r0.x
rcp r2.y, r0.y
rcp r2.z, r0.z
rcp r2.w, r0.w
mul r0, r1, r2
mul r1.xyz, r0.y, c1
mad r1.xyz, c0, r0.x, r1
mad r0.xyz, c2, r0.z, r1
mad r0.xyz, c3, r0.w, r0
mul r0.w, r6.y, r6.y
mad r0.w, r6.x, r6.x, -r0.w
mul r1, r6.yzzx, r6.xyzz
dp4 r2.x, c23, r1
dp4 r2.y, c24, r1
dp4 r2.z, c25, r1
mad r1.xyz, c26, r0.w, r2
mov r6.w, c29.x
dp4 r2.x, c20, r6
dp4 r2.y, c21, r6
dp4 r2.z, c22, r6
add r1.xyz, r1, r2
add oT4.xyz, r0, r1
dp4 r0.y, c5, v0
mul r1.x, r0.y, c14.x
mul r1.w, r1.x, c29.z
dp4 r0.x, c4, v0
dp4 r0.w, c7, v0
mul r1.xz, r0.xyww, c29.z
mad oT5.xy, r1.z, c15.zwzw, r1.xwzw
dp4 r0.z, c6, v0
mul r1.x, r0.z, c27.y
exp oT6.x, -r1.x
mov oPos, r0
mov oT5.zw, r0
dp3 r0.z, c8, v1
dp3 r0.x, c9, v1
dp3 r0.y, c10, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, r0, r6.zxyw
mad r1.xyz, r6.yzxw, r0.yzxw, -r1
mul r1.xyz, r1, v1.w
mov oT1.y, r1.x
mov oT1.z, r6.x
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r1.y
mov oT3.y, r1.z
mov oT2.z, r6.y
mov oT3.z, r6.z

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0
eefiecedomeojdmgkaehcnojobkicofkajccheemabaaaaaaamanaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcpiakaaaaeaaaabaaloacaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafjaaaaae
egiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
ckaabaaaaaaaaaaabkiacaaaaeaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaadaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaadaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafbccabaaaacaaaaaa
ckaabaaaabaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaa
adaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaaacaaaaaackiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaaacaaaaaackiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaaacaaaaaackiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaa
cgajbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaajgaebaaaacaaaaaajgaebaaa
abaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaadaaaaaa
dgaaaaafeccabaaaacaaaaaaakaabaaaacaaaaaadiaaaaaihcaabaaaaeaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaeaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaak
hcaabaaaaeaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaeaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaaeaaaaaa
dgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaa
bkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaadaaaaaadgaaaaaf
cccabaaaaeaaaaaackaabaaaadaaaaaadgaaaaafeccabaaaadaaaaaabkaabaaa
acaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaaaeaaaaaadgaaaaaficcabaaa
aeaaaaaackaabaaaaeaaaaaadgaaaaafeccabaaaaeaaaaaackaabaaaacaaaaaa
diaaaaahbcaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaak
bcaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaa
bbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaa
bbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaa
bbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaa
egacbaaaafaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaa
adaaaaaafgafbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaah
pcaabaaaafaaaaaafgafbaaaacaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaagaaaaaa
agaabaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaa
aeaaaaaakgakbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaaj
pcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaacaaaaaaegaobaaaafaaaaaa
dcaaaaajpcaabaaaacaaaaaaegaobaaaaeaaaaaakgakbaaaacaaaaaaegaobaaa
afaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaa
egaobaaaadaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaaeaaaaaaegaobaaa
aeaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaa
dcaaaaanpcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaa
acaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaadiaaaaai
hcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaak
hcaabaaaadaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaacaaaaaaegacbaaa
adaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaa
acaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
ajaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaahhccabaaaafaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
agaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_DynamicLightmapST;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_5.xyz * gl_Normal.y)
  ) + (v_6.xyz * gl_Normal.z)));
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * TANGENT.xyz));
  vec3 tmpvar_10;
  tmpvar_10 = (((tmpvar_7.yzx * tmpvar_9.zxy) - (tmpvar_7.zxy * tmpvar_9.yzx)) * TANGENT.w);
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.y = tmpvar_10.x;
  tmpvar_11.z = tmpvar_7.x;
  tmpvar_11.w = tmpvar_3.x;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_9.y;
  tmpvar_12.y = tmpvar_10.y;
  tmpvar_12.z = tmpvar_7.y;
  tmpvar_12.w = tmpvar_3.y;
  vec4 tmpvar_13;
  tmpvar_13.x = tmpvar_9.z;
  tmpvar_13.y = tmpvar_10.z;
  tmpvar_13.z = tmpvar_7.z;
  tmpvar_13.w = tmpvar_3.z;
  tmpvar_1.zw = ((gl_MultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
  vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - tmpvar_3.x);
  vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - tmpvar_3.y);
  vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - tmpvar_3.z);
  vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * tmpvar_7.x) + (tmpvar_15 * tmpvar_7.y)) + (tmpvar_16 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  vec4 o_19;
  vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_2 * 0.5);
  vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  xlv_TEXCOORD5 = o_19;
  xlv_TEXCOORD6 = tmpvar_2.z;
  xlv_TEXCOORD7 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D unity_DynamicLightmap;
uniform vec4 unity_DynamicLightmap_HDR;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz * _Color.xyz);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  c_2.w = 0.0;
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  c_2.xyz = (tmpvar_5 * xlv_TEXCOORD4);
  vec4 c_8;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_WorldSpaceCameraPos - tmpvar_3)));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_11;
  tmpvar_11 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_10 + tmpvar_9)))
  ), (_Shininess * 128.0)) * tmpvar_4.w);
  c_8.xyz = (((
    ((tmpvar_5 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_10)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_11)
  ) * (tmpvar_7.x * 2.0)) + ((tmpvar_5 * _LightColor0.xyz) * (
    (((tmpvar_7.x * 2.0) * (pow (
      max (0.0, dot (tmpvar_9, -((tmpvar_10 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_8.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_11) * tmpvar_7.x);
  vec4 tmpvar_12;
  tmpvar_12 = (c_2 + c_8);
  c_2.w = tmpvar_12.w;
  vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD7.zw);
  c_2.xyz = (tmpvar_12.xyz + (tmpvar_5 * pow (
    ((unity_DynamicLightmap_HDR.x * tmpvar_13.w) * tmpvar_13.xyz)
  , unity_DynamicLightmap_HDR.yyy)));
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD6))
  ), 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 21 [_MainTex_ST]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 19 [unity_4LightAtten0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 20 [unity_DynamicLightmapST]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
"vs_3_0
def c22, 0, 1, 0.5, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord2 v4
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord6 o7.x
dcl_texcoord7 o8
mad o1.xy, v3, c21, c21.zwzw
mad o8.zw, v4.xyxy, c20.xyxy, c20
dp4 r0.x, c8, v0
add r1, -r0.x, c16
mov o2.w, r0.x
dp4 r0.x, c9, v0
add r2, -r0.x, c17
mov o3.w, r0.x
mul r0.xyz, c12.zxyw, v2.y
mad r0.xyz, c11.zxyw, v2.x, r0
mad r0.xyz, c13.zxyw, v2.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mul r3, r0.z, r2
mul r2, r2, r2
mad r2, r1, r1, r2
mad r1, r1, r0.y, r3
dp4 r0.w, c10, v0
add r3, -r0.w, c18
mov o4.zw, r0.xyxw
mad r1, r3, r0.x, r1
mad r2, r3, r3, r2
rsq r3.x, r2.x
rsq r3.y, r2.y
rsq r3.z, r2.z
rsq r3.w, r2.w
mov r4.y, c22.y
mad r2, r2, c19, r4.y
mul r1, r1, r3
max r1, r1, c22.x
rcp r3.x, r2.x
rcp r3.y, r2.y
rcp r3.z, r2.z
rcp r3.w, r2.w
mul r1, r1, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad o5.xyz, c3, r1.w, r1
dp4 r1.y, c5, v0
mul r0.w, r1.y, c14.x
mul r2.w, r0.w, c22.z
dp4 r1.x, c4, v0
dp4 r1.w, c7, v0
mul r2.xz, r1.xyww, c22.z
mad o6.xy, r2.z, c15.zwzw, r2.xwzw
dp4 r1.z, c6, v0
mov o0, r1
mov o6.zw, r1
mov o7.x, r1.z
dp3 r1.z, c8, v1
dp3 r1.x, c9, v1
dp3 r1.y, c10, v1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mov o2.x, r1.z
mul r2.xyz, r0, r1
mad r2.xyz, r0.zxyw, r1.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r0.y
mov o3.x, r1.x
mov o4.x, r1.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r0.z
mov o8.xy, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityLightmaps" 32
Vector 16 [unity_DynamicLightmapST]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityLightmaps" 4
"vs_4_0
eefiecedngiopdhaedonnccddlckcfkmbflolblpabaaaaaaomalaaaaadaaaaaa
cmaaaaaaceabaaaaceacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapadaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaomaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmaajaaaaeaaaabaahaacaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
akaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafjaaaaaeegiocaaaaeaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
eccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaa
agaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaadgaaaaafmccabaaa
agaaaaaakgaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaiccaabaaa
abaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiecaabaaa
abaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaibcaabaaa
abaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaiccaabaaa
acaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiecaabaaa
acaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaibcaabaaa
acaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaacaaaaaa
ckbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiecaabaaaacaaaaaa
ckbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaibcaabaaaacaaaaaa
ckbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgbfbaaaabaaaaaajgiecaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaacaaaaaajgiecaaaadaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaajgiecaaaadaaaaaaaoaaaaaakgbkbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
cgajbaaaabaaaaaajgaebaaaacaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaa
acaaaaaaakaabaaaadaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaabaaaaaa
dgaaaaafbccabaaaacaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaeaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaeaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaak
hcaabaaaaeaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaeaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaaeaaaaaa
dgaaaaafbccabaaaadaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaaaeaaaaaa
bkaabaaaacaaaaaadgaaaaafeccabaaaadaaaaaackaabaaaabaaaaaadgaaaaaf
cccabaaaadaaaaaabkaabaaaadaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaa
adaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaaaeaaaaaadgaaaaafeccabaaa
aeaaaaaaakaabaaaabaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaaeaaaaaa
aaaaaaajpcaabaaaacaaaaaafgafbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaa
adaaaaaadiaaaaahpcaabaaaadaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
diaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaaaaaaaaj
pcaabaaaafaaaaaaagaabaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaacaaaaaa
aaaaaaajpcaabaaaaeaaaaaakgakbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaa
aeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaafgafbaaaabaaaaaa
egaobaaaadaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaaeaaaaaaagaabaaa
abaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaafaaaaaa
egaobaaaafaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaa
aeaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaaeeaaaaafpcaabaaaadaaaaaa
egaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaa
acaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaak
pcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaa
acaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
deaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaa
ahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aiaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaacaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
fcaabaaaaaaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaadp
aaaaaaahdccabaaaagaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadcaaaaal
mccabaaaahaaaaaaagbebaaaafaaaaaaagiecaaaaeaaaaaaabaaaaaakgiocaaa
aeaaaaaaabaaaaaadgaaaaaidccabaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0_level_9_1
eefiecedpncnjdcgbhagbmnaccghcdnidphhcfdcabaaaaaaaabaaaaaaeaaaaaa
daaaaaaacaafaaaacaaoaaaabiapaaaaebgpgodjoiaeaaaaoiaeaaaaaaacpopp
hiaeaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaanaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaiaaaeaaajaaaaaaaaaa
adaaaaaaaeaaanaaaaaaaaaaadaaamaaahaabbaaaaaaaaaaaeaaabaaabaabiaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbjaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaacaaaajabfaaaakaafaaaaadaaaaacia
acaaaajabgaaaakaafaaaaadaaaaaeiaacaaaajabhaaaakaafaaaaadabaaabia
acaaffjabfaaffkaafaaaaadabaaaciaacaaffjabgaaffkaafaaaaadabaaaeia
acaaffjabhaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabia
acaakkjabfaakkkaafaaaaadabaaaciaacaakkjabgaakkkaafaaaaadabaaaeia
acaakkjabhaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahia
aaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaia
abaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeiaajaaaaadadaaabia
afaaoekaacaaoeiaajaaaaadadaaaciaagaaoekaacaaoeiaajaaaaadadaaaeia
ahaaoekaacaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaaaaiaadaaoeiaabaaaaac
abaaaiiabjaaaakaajaaaaadacaaabiaacaaoekaabaaoeiaajaaaaadacaaacia
adaaoekaabaaoeiaajaaaaadacaaaeiaaeaaoekaabaaoeiaacaaaaadaeaaahoa
aaaaoeiaacaaoeiaafaaaaadaaaaapiaaaaaffjabcaaoekaaeaaaaaeaaaaapia
bbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabdaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeiaafaaaaadacaaapiaaaaaffia
akaaoekaaeaaaaaeacaaapiaajaaoekaaaaaaaiaacaaoeiaaeaaaaaeacaaapia
alaaoekaaaaakkiaacaaoeiaaeaaaaaeafaaapoaamaaoekaaaaappiaacaaoeia
afaaaaadaaaaapiaaaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
baaaoekaaaaappjaaaaaoeiaafaaaaadabaaaiiaaaaakkiabiaaffkaaoaaaaac
aaaaaeoaabaappibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaafaaaaadaaaaahiaabaaffjabcaamjkaaeaaaaaeaaaaahia
bbaamjkaabaaaajaaaaaoeiaaeaaaaaeaaaaahiabdaamjkaabaakkjaaaaaoeia
aiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaad
aaaaahiaaaaappiaaaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaadacaaahia
aaaaoeiaabaanciaaeaaaaaeacaaahiaabaamjiaaaaamjiaacaaoeibafaaaaad
acaaahiaacaaoeiaabaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoa
abaaaaiaafaaaaadadaaahiaaaaaffjabcaaoekaaeaaaaaeadaaahiabbaaoeka
aaaaaajaadaaoeiaaeaaaaaeadaaahiabdaaoekaaaaakkjaadaaoeiaaeaaaaae
adaaahiabeaaoekaaaaappjaadaaoeiaabaaaaacabaaaioaadaaaaiaabaaaaac
acaaaboaaaaaaaiaabaaaaacadaaaboaaaaaffiaabaaaaacacaaacoaacaaffia
abaaaaacadaaacoaacaakkiaabaaaaacacaaaeoaabaaffiaabaaaaacadaaaeoa
abaakkiaabaaaaacacaaaioaadaaffiaabaaaaacadaaaioaadaakkiappppaaaa
fdeieefcpiaiaaaaeaaaabaadoacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaa
fjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaaamaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aeaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaa
ogikcaaaaaaaaaaaanaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaadaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaadaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaacaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
jgaebaaaacaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaa
acaaaaaaakaabaaaadaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaa
dgaaaaafeccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaaadaaaaaa
akaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaf
iccabaaaadaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaa
adaaaaaabkaabaaaadaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaadaaaaaa
dgaaaaafeccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaf
icaabaaaacaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaacaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaa
ajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaiaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaa
akaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaa
egiocaaaacaaaaaaalaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaneaaaaaaagaaaaaa
aaaaaaaaadaaaaaaabaaaaaaaealaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
neaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0_level_9_1
eefiecedpdpnokccpfmocjnilpfmljgkaokjpeboabaaaaaahabeaaaaaeaaaaaa
daaaaaaaniagaaaajabcaaaaiibdaaaaebgpgodjkaagaaaakaagaaaaaaacpopp
ceagaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaanaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaacgaaahaaakaaaaaaaaaa
acaaaiaaaeaabbaaaaaaaaaaadaaaaaaaeaabfaaaaaaaaaaadaaamaaahaabjaa
aaaaaaaaaeaaabaaabaacaaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafcbaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaabiaacaaaaja
bnaaaakaafaaaaadaaaaaciaacaaaajaboaaaakaafaaaaadaaaaaeiaacaaaaja
bpaaaakaafaaaaadabaaabiaacaaffjabnaaffkaafaaaaadabaaaciaacaaffja
boaaffkaafaaaaadabaaaeiaacaaffjabpaaffkaacaaaaadaaaaahiaaaaaoeia
abaaoeiaafaaaaadabaaabiaacaakkjabnaakkkaafaaaaadabaaaciaacaakkja
boaakkkaafaaaaadabaaaeiaacaakkjabpaakkkaacaaaaadaaaaahiaaaaaoeia
abaaoeiaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaahiaaaaaffjabkaaoeka
aeaaaaaeaaaaahiabjaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiablaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaahiabmaaoekaaaaappjaaaaaoeiaacaaaaad
acaaapiaaaaaffibadaaoekaafaaaaadadaaapiaabaaffiaacaaoeiaafaaaaad
acaaapiaacaaoeiaacaaoeiaacaaaaadaeaaapiaaaaaaaibacaaoekaaeaaaaae
adaaapiaaeaaoeiaabaaaaiaadaaoeiaaeaaaaaeacaaapiaaeaaoeiaaeaaoeia
acaaoeiaacaaaaadaeaaapiaaaaakkibaeaaoekaaeaaaaaeadaaapiaaeaaoeia
abaakkiaadaaoeiaaeaaaaaeacaaapiaaeaaoeiaaeaaoeiaacaaoeiaahaaaaac
aeaaabiaacaaaaiaahaaaaacaeaaaciaacaaffiaahaaaaacaeaaaeiaacaakkia
ahaaaaacaeaaaiiaacaappiaabaaaaacafaaabiacbaaaakaaeaaaaaeacaaapia
acaaoeiaafaaoekaafaaaaiaafaaaaadadaaapiaadaaoeiaaeaaoeiaalaaaaad
adaaapiaadaaoeiacbaaffkaagaaaaacaeaaabiaacaaaaiaagaaaaacaeaaacia
acaaffiaagaaaaacaeaaaeiaacaakkiaagaaaaacaeaaaiiaacaappiaafaaaaad
acaaapiaadaaoeiaaeaaoeiaafaaaaadadaaahiaacaaffiaahaaoekaaeaaaaae
adaaahiaagaaoekaacaaaaiaadaaoeiaaeaaaaaeacaaahiaaiaaoekaacaakkia
adaaoeiaaeaaaaaeacaaahiaajaaoekaacaappiaacaaoeiaafaaaaadaaaaaiia
abaaffiaabaaffiaaeaaaaaeaaaaaiiaabaaaaiaabaaaaiaaaaappibafaaaaad
adaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaanaaoekaadaaoeiaajaaaaad
aeaaaciaaoaaoekaadaaoeiaajaaaaadaeaaaeiaapaaoekaadaaoeiaaeaaaaae
adaaahiabaaaoekaaaaappiaaeaaoeiaabaaaaacabaaaiiacbaaaakaajaaaaad
aeaaabiaakaaoekaabaaoeiaajaaaaadaeaaaciaalaaoekaabaaoeiaajaaaaad
aeaaaeiaamaaoekaabaaoeiaacaaaaadadaaahiaadaaoeiaaeaaoeiaacaaaaad
aeaaahoaacaaoeiaadaaoeiaafaaaaadacaaapiaaaaaffjabkaaoekaaeaaaaae
acaaapiabjaaoekaaaaaaajaacaaoeiaaeaaaaaeacaaapiablaaoekaaaaakkja
acaaoeiaaeaaaaaeacaaapiabmaaoekaaaaappjaacaaoeiaafaaaaadadaaapia
acaaffiabcaaoekaaeaaaaaeadaaapiabbaaoekaacaaaaiaadaaoeiaaeaaaaae
adaaapiabdaaoekaacaakkiaadaaoeiaaeaaaaaeafaaapoabeaaoekaacaappia
adaaoeiaafaaaaadacaaapiaaaaaffjabgaaoekaaeaaaaaeacaaapiabfaaoeka
aaaaaajaacaaoeiaaeaaaaaeacaaapiabhaaoekaaaaakkjaacaaoeiaaeaaaaae
acaaapiabiaaoekaaaaappjaacaaoeiaafaaaaadaaaaaiiaacaakkiacaaaffka
aoaaaaacaaaaaeoaaaaappibaeaaaaaeaaaaadmaacaappiaaaaaoekaacaaoeia
abaaaaacaaaaammaacaaoeiaafaaaaadacaaahiaabaaffjabkaamjkaaeaaaaae
acaaahiabjaamjkaabaaaajaacaaoeiaaeaaaaaeacaaahiablaamjkaabaakkja
acaaoeiaaiaaaaadaaaaaiiaacaaoeiaacaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadacaaahiaaaaappiaacaaoeiaabaaaaacabaaaboaacaakkiaafaaaaad
adaaahiaabaanciaacaaoeiaaeaaaaaeadaaahiaabaamjiaacaamjiaadaaoeib
afaaaaadadaaahiaadaaoeiaabaappjaabaaaaacabaaacoaadaaaaiaabaaaaac
abaaaeoaabaaaaiaabaaaaacabaaaioaaaaaaaiaabaaaaacacaaaboaacaaaaia
abaaaaacadaaaboaacaaffiaabaaaaacacaaacoaadaaffiaabaaaaacadaaacoa
adaakkiaabaaaaacacaaaeoaabaaffiaabaaaaacadaaaeoaabaakkiaabaaaaac
acaaaioaaaaaffiaabaaaaacadaaaioaaaaakkiappppaaaafdeieefclaalaaaa
eaaaabaaomacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaa
abaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaa
adaaaaaabdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaeaaaaaaabaaaaaa
bjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaa
anaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaabaaaaaajgiecaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaajgiecaaaadaaaaaaamaaaaaaagbabaaa
abaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaajgiecaaaadaaaaaa
aoaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafbccabaaaacaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaacgajbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaa
jgaebaaaabaaaaaajgaebaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaa
acaaaaaaakaabaaaacaaaaaadgaaaaafeccabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficcabaaa
acaaaaaaakaabaaaadaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaaaaaaaaa
dgaaaaafbccabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaafcccabaaaadaaaaaa
bkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadgaaaaaf
eccabaaaadaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaa
adaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaadaaaaaadgaaaaafeccabaaa
aeaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
abaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
cmaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadgaaaaaficaabaaaabaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaajpcaabaaaacaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaa
abaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
aaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaaabaaaaaa
acaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaa
abaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaa
abaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaa
kgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaa
afaaaaaaegaobaaaafaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaacaaaaaa
egaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaaeeaaaaafpcaabaaa
adaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaa
egiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
aoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
egaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
adaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
abaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaaagaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaahhccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaacaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaagaaaaaaegiocaaaacaaaaaaalaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
oaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaa
neaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaa
neaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 7 [_Color]
Float 6 [_Distortion]
Vector 2 [_LightColor0]
Float 5 [_Power]
Float 4 [_Scale]
Float 9 [_Shininess]
Vector 3 [_SpecColor]
Vector 8 [_SubColor]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Thickness] 2D 2
"ps_2_0
def c10, 2, -1, 0, 1
def c11, 128, 0, 0, 0
dcl t0.xy
dcl t1
dcl t2
dcl t3
dcl_pp t4.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, t0, s1
texld_pp r1, t0, s0
texld_pp r2, t0, s2
mov r3.x, -t1.w
mov r3.y, -t2.w
mov r3.z, -t3.w
add r3.xyz, r3, c0
nrm_pp r4.xyz, r3
dp3_pp r4.w, c1, c1
rsq_pp r4.w, r4.w
mad_pp r3.xyz, c1, r4.w, r4
mul_pp r5.xyz, r4.w, c1
nrm_pp r6.xyz, r3
mad_pp r3.x, r0.w, c10.x, c10.y
mad_pp r3.y, r0.y, c10.x, c10.y
dp2add_sat_pp r3.w, r3, r3, c10.z
add_pp r3.w, -r3.w, c10.w
rsq_pp r3.w, r3.w
rcp_pp r3.z, r3.w
dp3_pp r0.x, t1, r3
dp3_pp r0.y, t2, r3
dp3_pp r0.z, t3, r3
dp3_pp r0.w, r0, r6
max r4.w, r0.w, c10.z
mov r0.w, c9.x
mul r0.w, r0.w, c11.x
pow r5.w, r4.w, r0.w
mul r0.w, r1.w, r5.w
mul_pp r1.xyz, r1, c7
mov r3.xyz, c2
mul r2.yzw, r3.wzyx, c3.wzyx
mul r2.yzw, r0.w, r2
dp3_pp r0.w, r0, r5
mad_pp r0.xyz, r0, c6.x, r5
dp3_pp r1.w, r4, -r0
max r0.x, r1.w, c10.z
pow r1.w, r0.x, c5.x
mul r1.w, r1.w, c4.x
add r1.w, r1.w, r1.w
max_pp r3.x, r0.w, c10.z
mul_pp r0.xyz, r1, c2
mad r2.yzw, r0.wzyx, r3.x, r2
add_pp r2.yzw, r2, r2
mul r0.w, r2.x, r1.w
mul_pp r3.xyz, r0.w, c8
mad_pp r0.xyz, r0, r3, r2.wzyx
mad_pp r0.xyz, r1, t4, r0
mov_pp r0.w, c10.w
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Thickness] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedpcigokkooengcbmhlplfiplhkjflcfnjabaaaaaaoeahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmeagaaaa
eaaaaaaalbabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadgaaaaaf
bcaabaaaaaaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaa
adaaaaaadgaaaaafecaabaaaaaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
ccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
aeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaed
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaa
aaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaa
kgikcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaa
mgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaajaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaapaaaaaibcaabaaaaaaaaaaaagaabaaaaaaaaaaaagiacaaaaaaaaaaa
ajaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
agaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaa
agajbaaaadaaaaaaaaaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaa
aaaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaaihcaabaaaadaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
alaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
jgahbaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaa
afaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Thickness] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0_level_9_1
eefiecediopmnlanhmikdlapbfebnebkepanhlpjabaaaaaaoialaaaaaeaaaaaa
daaaaaaadaaeaaaapmakaaaalealaaaaebgpgodjpiadaaaapiadaaaaaaacpppp
jiadaaaagaaaaaaaaeaadaaaaaaagaaaaaaagaaaadaaceaaaaaagaaaaaaaaaaa
acababaaabacacaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaaaeaaacaaaaaaaaaa
abaaaeaaabaaagaaaaaaaaaaacaaaaaaabaaahaaaaaaaaaaaaacppppfbaaaaaf
aiaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafajaaapkaaaaaaaed
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaaplabpaaaaac
aaaaaaiaaeaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaaaaaoelaabaioekaecaaaaad
abaacpiaaaaaoelaaaaioekaecaaaaadacaacpiaaaaaoelaacaioekaabaaaaac
adaaabiaabaapplbabaaaaacadaaaciaacaapplbabaaaaacadaaaeiaadaapplb
acaaaaadadaaahiaadaaoeiaagaaoekaceaaaaacaeaachiaadaaoeiaaiaaaaad
aeaaciiaahaaoekaahaaoekaahaaaaacaeaaciiaaeaappiaaeaaaaaeadaachia
ahaaoekaaeaappiaaeaaoeiaafaaaaadafaachiaaeaappiaahaaoekaceaaaaac
agaachiaadaaoeiaaeaaaaaeadaacbiaaaaappiaaiaaaakaaiaaffkaaeaaaaae
adaacciaaaaaffiaaiaaaakaaiaaffkafkaaaaaeadaadiiaadaaoeiaadaaoeia
aiaakkkaacaaaaadadaaciiaadaappibaiaappkaahaaaaacadaaciiaadaappia
agaaaaacadaaceiaadaappiaaiaaaaadaaaacbiaabaaoelaadaaoeiaaiaaaaad
aaaacciaacaaoelaadaaoeiaaiaaaaadaaaaceiaadaaoelaadaaoeiaaiaaaaad
aaaaciiaaaaaoeiaagaaoeiaalaaaaadaeaaaiiaaaaappiaaiaakkkaabaaaaac
aaaaaiiaafaaaakaafaaaaadaaaaaiiaaaaappiaajaaaakacaaaaaadafaaaiia
aeaappiaaaaappiaafaaaaadaaaaaiiaabaappiaafaappiaafaaaaadabaachia
abaaoeiaadaaoekaabaaaaacadaaahiaaaaaoekaafaaaaadacaaaoiaadaablia
abaablkaafaaaaadacaaaoiaaaaappiaacaaoeiaaiaaaaadaaaaciiaaaaaoeia
afaaoeiaaeaaaaaeaaaachiaaaaaoeiaacaakkkaafaaoeiaaiaaaaadabaaciia
aeaaoeiaaaaaoeibalaaaaadaaaaabiaabaappiaaiaakkkacaaaaaadabaaaiia
aaaaaaiaacaaffkaafaaaaadabaaaiiaabaappiaacaaaakaacaaaaadabaaaiia
abaappiaabaappiaalaaaaadadaacbiaaaaappiaaiaakkkaafaaaaadaaaachia
abaaoeiaaaaaoekaaeaaaaaeacaaaoiaaaaabliaadaaaaiaacaaoeiaacaaaaad
acaacoiaacaaoeiaacaaoeiaafaaaaadaaaaaiiaacaaaaiaabaappiaafaaaaad
adaachiaaaaappiaaeaaoekaaeaaaaaeaaaachiaaaaaoeiaadaaoeiaacaablia
aeaaaaaeaaaachiaabaaoeiaaeaaoelaaaaaoeiaabaaaaacaaaaciiaaiaappka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcmeagaaaaeaaaaaaalbabaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaa
dkbabaaaacaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaaadaaaaaadgaaaaaf
ecaabaaaaaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaa
adaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaa
egaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaa
egbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaa
aeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaa
egacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaakaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaa
egiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaa
ajaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaa
aaaaaaaaajaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaapaaaaai
bcaabaaaaaaaaaaaagaabaaaaaaaaaaaagiacaaaaaaaaaaaajaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadcaaaaaj
ocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaa
aaaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaai
hcaabaaaadaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaajgahbaaaaaaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaafaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apapaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" }
Vector 8 [_Color]
Float 7 [_Distortion]
Vector 3 [_LightColor0]
Float 6 [_Power]
Float 5 [_Scale]
Float 10 [_Shininess]
Vector 4 [_SpecColor]
Vector 9 [_SubColor]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [unity_DynamicLightmap_HDR]
SetTexture 0 [unity_DynamicLightmap] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_Thickness] 2D 3
"ps_3_0
def c11, 2, -1, 0, 1
def c12, 128, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4_pp v4.xyz
dcl_texcoord7 v5.zw
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
mov r0.x, v1.w
mov r0.y, v2.w
mov r0.z, v3.w
add r0.xyz, -r0, c0
nrm_pp r1.xyz, r0
dp3_pp r0.x, c1, c1
rsq_pp r0.x, r0.x
mad_pp r0.yzw, c1.xxyz, r0.x, r1.xxyz
mul_pp r2.xyz, r0.x, c1
nrm_pp r3.xyz, r0.yzww
texld_pp r0, v0, s2
mad_pp r0.xy, r0.wyzw, c11.x, c11.y
dp2add_sat_pp r0.w, r0, r0, c11.z
add_pp r0.w, -r0.w, c11.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
dp3_pp r4.x, v1, r0
dp3_pp r4.y, v2, r0
dp3_pp r4.z, v3, r0
dp3_pp r0.x, r4, r3
max r1.w, r0.x, c11.z
mov r0.x, c10.x
mul r0.x, r0.x, c12.x
pow r2.w, r1.w, r0.x
texld_pp r0, v0, s1
mul r0.w, r0.w, r2.w
mul_pp r0.xyz, r0, c8
mov r3.xyz, c3
mul r3.xyz, r3, c4
mul r3.xyz, r0.w, r3
dp3_pp r0.w, r4, r2
mad_pp r2.xyz, r4, c7.x, r2
dp3_pp r1.x, r1, -r2
max r2.x, r1.x, c11.z
pow r1.x, r2.x, c6.x
mov r1.z, c11.z
dp2add r1.x, r1.x, c5.x, r1.z
max_pp r1.y, r0.w, c11.z
mul_pp r2.xyz, r0, c3
mad r1.yzw, r2.xxyz, r1.y, r3.xxyz
add_pp r1.yzw, r1, r1
texld_pp r3, v0, s3
mul r0.w, r1.x, r3.x
mul_pp r3.xyz, r0.w, c9
mad_pp r1.xyz, r2, r3, r1.yzww
mad_pp r1.xyz, r0, v4, r1
texld_pp r2, v5.zwzw, s0
mul_pp r0.w, r2.w, c2.x
mul_pp r2.xyz, r2, r0.w
log_pp r3.x, r2.x
log_pp r3.y, r2.y
log_pp r3.z, r2.z
mul_pp r2.xyz, r3, c2.y
exp_pp r3.x, r2.x
exp_pp r3.y, r2.y
exp_pp r3.z, r2.z
mad_pp oC0.xyz, r0, r3, r1
mov_pp oC0.w, c11.w

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Thickness] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [unity_DynamicLightmap] 2D 0
ConstBuffer "$Globals" 224
Vector 80 [unity_DynamicLightmap_HDR]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedpnahmnhcknpbphklhhkanmdgfbmhnkddabaaaaaapaaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcliahaaaaeaaaaaaaooabaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaad
mcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadgaaaaaf
bcaabaaaaaaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaa
adaaaaaadgaaaaafecaabaaaaaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
ccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
aeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaed
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaa
aaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaa
kgikcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaa
mgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaajaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaapaaaaaibcaabaaaaaaaaaaaagaabaaaaaaaaaaaagiacaaaaaaaaaaa
ajaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
agaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaa
agajbaaaadaaaaaaaaaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaa
aaaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaaihcaabaaaadaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
alaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
jgahbaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaa
afaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaagaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
acaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaapgapbaaaaaaaaaaacpaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
bjaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 7 [_Color]
Float 6 [_Distortion]
Vector 2 [_LightColor0]
Float 5 [_Power]
Float 4 [_Scale]
Float 9 [_Shininess]
Vector 3 [_SpecColor]
Vector 8 [_SubColor]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_Thickness] 2D 3
"ps_2_0
def c10, 2, -1, 0, 1
def c11, 128, 0, 0, 0
dcl t0.xy
dcl t1
dcl t2
dcl t3
dcl_pp t4.xyz
dcl_pp t5
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texld_pp r0, t0, s2
texld_pp r1, t0, s1
texldp_pp r2, t5, s0
texld_pp r3, t0, s3
mov r4.x, -t1.w
mov r4.y, -t2.w
mov r4.z, -t3.w
add r4.xyz, r4, c0
nrm_pp r5.xyz, r4
dp3_pp r5.w, c1, c1
rsq_pp r5.w, r5.w
mad_pp r4.xyz, c1, r5.w, r5
mul_pp r6.xyz, r5.w, c1
nrm_pp r7.xyz, r4
mad_pp r4.x, r0.w, c10.x, c10.y
mad_pp r4.y, r0.y, c10.x, c10.y
dp2add_sat_pp r4.w, r4, r4, c10.z
add_pp r4.w, -r4.w, c10.w
rsq_pp r4.w, r4.w
rcp_pp r4.z, r4.w
dp3_pp r0.x, t1, r4
dp3_pp r0.y, t2, r4
dp3_pp r0.z, t3, r4
dp3_pp r0.w, r0, r7
max r5.w, r0.w, c10.z
mov r0.w, c9.x
mul r0.w, r0.w, c11.x
pow r6.w, r5.w, r0.w
mul r0.w, r1.w, r6.w
mul_pp r1.xyz, r1, c7
mov r4.xyz, c2
mul r2.yzw, r4.wzyx, c3.wzyx
mul r2.yzw, r0.w, r2
dp3_pp r0.w, r0, r6
mad_pp r0.xyz, r0, c6.x, r6
dp3_pp r1.w, r5, -r0
max r0.x, r1.w, c10.z
pow r1.w, r0.x, c5.x
mul r1.w, r1.w, c4.x
max_pp r3.y, r0.w, c10.z
mul_pp r0.xyz, r1, c2
mad r2.yzw, r0.wzyx, r3.y, r2
add r0.w, r2.x, r2.x
mul r1.w, r1.w, r0.w
mul r1.w, r3.x, r1.w
mul_pp r3.xyz, r1.w, c8
mul_pp r0.xyz, r0, r3
mad_pp r0.xyz, r2.wzyx, r0.w, r0
mad_pp r0.xyz, r1, t4, r0
mov_pp r0.w, c10.w
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Thickness] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedpbaogbneoimpmmkennjacoldfncnfbkgabaaaaaajmaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgeahaaaaeaaaaaaanjabaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaad
lcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadgaaaaaf
bcaabaaaaaaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaa
adaaaaaadgaaaaafecaabaaaaaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
ccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
aeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaed
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaa
aaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaa
kgikcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaa
mgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaajaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
ajaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
agaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaa
agajbaaaadaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaaagaaaaaapgbpbaaa
agaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaaaaaaaaahicaabaaaabaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaa
diaaaaaihcaabaaaadaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaajgahbaaaaaaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaafaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" }
Vector 8 [_Color]
Float 7 [_Distortion]
Vector 3 [_LightColor0]
Float 6 [_Power]
Float 5 [_Scale]
Float 10 [_Shininess]
Vector 4 [_SpecColor]
Vector 9 [_SubColor]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [unity_DynamicLightmap_HDR]
SetTexture 0 [unity_DynamicLightmap] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
SetTexture 4 [_Thickness] 2D 4
"ps_3_0
def c11, 2, -1, 0, 1
def c12, 128, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4_pp v4.xyz
dcl_texcoord5 v5
dcl_texcoord7 v6.zw
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
mov r0.x, v1.w
mov r0.y, v2.w
mov r0.z, v3.w
add r0.xyz, -r0, c0
nrm_pp r1.xyz, r0
dp3_pp r0.x, c1, c1
rsq_pp r0.x, r0.x
mad_pp r0.yzw, c1.xxyz, r0.x, r1.xxyz
mul_pp r2.xyz, r0.x, c1
nrm_pp r3.xyz, r0.yzww
texld_pp r0, v0, s3
mad_pp r0.xy, r0.wyzw, c11.x, c11.y
dp2add_sat_pp r0.w, r0, r0, c11.z
add_pp r0.w, -r0.w, c11.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
dp3_pp r4.x, v1, r0
dp3_pp r4.y, v2, r0
dp3_pp r4.z, v3, r0
dp3_pp r0.x, r4, r3
max r1.w, r0.x, c11.z
mov r0.x, c10.x
mul r0.x, r0.x, c12.x
pow r2.w, r1.w, r0.x
texld_pp r0, v0, s2
mul r0.w, r0.w, r2.w
mul_pp r0.xyz, r0, c8
mov r3.xyz, c3
mul r3.xyz, r3, c4
mul r3.xyz, r0.w, r3
dp3_pp r0.w, r4, r2
mad_pp r2.xyz, r4, c7.x, r2
dp3_pp r1.x, r1, -r2
max r2.x, r1.x, c11.z
pow r1.x, r2.x, c6.x
mul r1.x, r1.x, c5.x
max_pp r1.y, r0.w, c11.z
mul_pp r2.xyz, r0, c3
mad r1.yzw, r2.xxyz, r1.y, r3.xxyz
texldp_pp r3, v5, s1
add r0.w, r3.x, r3.x
mul r1.x, r1.x, r0.w
texld_pp r3, v0, s4
mul r1.x, r1.x, r3.x
mul_pp r3.xyz, r1.x, c9
mul_pp r2.xyz, r2, r3
mad_pp r1.xyz, r1.yzww, r0.w, r2
mad_pp r1.xyz, r0, v4, r1
texld_pp r2, v6.zwzw, s0
mul_pp r0.w, r2.w, c2.x
mul_pp r2.xyz, r2, r0.w
log_pp r3.x, r2.x
log_pp r3.y, r2.y
log_pp r3.z, r2.z
mul_pp r2.xyz, r3, c2.y
exp_pp r3.x, r2.x
exp_pp r3.y, r2.y
exp_pp r3.z, r2.z
mad_pp oC0.xyz, r0, r3, r1
mov_pp oC0.w, c11.w

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Thickness] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_ShadowMapTexture] 2D 1
SetTexture 4 [unity_DynamicLightmap] 2D 0
ConstBuffer "$Globals" 224
Vector 80 [unity_DynamicLightmap_HDR]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedbljipaghnbjhcgkoihcdnpikadmihnopabaaaaaakiajaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfiaiaaaaeaaaaaaabgacaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadlcbabaaaagaaaaaagcbaaaad
mcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadgaaaaaf
bcaabaaaaaaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaa
adaaaaaadgaaaaafecaabaaaaaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
ccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
aeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaed
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaa
aaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaa
kgikcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaa
mgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaajaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
ajaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
agaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaa
agajbaaaadaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaaagaaaaaapgbpbaaa
agaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaaaaaaaaahicaabaaaabaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aeaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaa
diaaaaaihcaabaaaadaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaajgahbaaaaaaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaafaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaahaaaaaaeghobaaaaeaaaaaa
aagabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaacaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
aaaaaaaacpaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaabjaaaaafhcaabaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Thickness] 2D 2
SetTexture 2 [_BumpMap] 2D 1
SetTexture 15 [_ShadowMapTexture] 2D 15
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
"ps_4_0_level_9_1
eefiecedapejlmidbmihaecbmechlibipckakkdkabaaaaaageanaaaaafaaaaaa
deaaaaaajmaeaaaafaamaaaagaamaaaadaanaaaaebgpgodjgaaeaaaagaaeaaaa
aaacpppppaadaaaahaaaaaaaafaadeaaaaaahaaaaaaahaaaaeaaceaaaaaahaaa
apapaaaaaaaaabaaacabacaaabacadaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaa
aeaaacaaaaaaaaaaabaaaeaaabaaagaaaaaaaaaaacaaaaaaabaaahaaaaaaaaaa
adaabiaaabaaaiaaaaaaaaaaaaacppppfbaaaaafajaaapkaaaaaaaeaaaaaialp
aaaaaaaaaaaaiadpfbaaaaafakaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaaiaadaaaplabpaaaaacaaaaaaiaaeaachlabpaaaaac
aaaaaaiaafaacplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaecaaaaadaaaacpia
aaaaoelaacaioekaecaaaaadabaacpiaaaaaoelaabaioekaecaaaaadacaacpia
afaaoelaaaaioekaecaaaaadadaacpiaaaaaoelaadaioekaabaaaaacaeaaabia
abaapplbabaaaaacaeaaaciaacaapplbabaaaaacaeaaaeiaadaapplbacaaaaad
aeaaahiaaeaaoeiaagaaoekaceaaaaacafaachiaaeaaoeiaaiaaaaadafaaciia
ahaaoekaahaaoekaahaaaaacafaaciiaafaappiaaeaaaaaeaeaachiaahaaoeka
afaappiaafaaoeiaafaaaaadagaachiaafaappiaahaaoekaceaaaaacahaachia
aeaaoeiaaeaaaaaeaeaacbiaaaaappiaajaaaakaajaaffkaaeaaaaaeaeaaccia
aaaaffiaajaaaakaajaaffkafkaaaaaeaeaadiiaaeaaoeiaaeaaoeiaajaakkka
acaaaaadaeaaciiaaeaappibajaappkaahaaaaacaeaaciiaaeaappiaagaaaaac
aeaaceiaaeaappiaaiaaaaadaaaacbiaabaaoelaaeaaoeiaaiaaaaadaaaaccia
acaaoelaaeaaoeiaaiaaaaadaaaaceiaadaaoelaaeaaoeiaaiaaaaadaaaaciia
aaaaoeiaahaaoeiaalaaaaadafaaaiiaaaaappiaajaakkkaabaaaaacaaaaaiia
afaaaakaafaaaaadaaaaaiiaaaaappiaakaaaakacaaaaaadagaaaiiaafaappia
aaaappiaafaaaaadaaaaaiiaabaappiaagaappiaafaaaaadabaachiaabaaoeia
adaaoekaabaaaaacaeaaahiaaaaaoekaafaaaaadacaaaoiaaeaabliaabaablka
afaaaaadacaaaoiaaaaappiaacaaoeiaaiaaaaadaaaaciiaaaaaoeiaagaaoeia
aeaaaaaeaaaachiaaaaaoeiaacaakkkaagaaoeiaaiaaaaadabaaciiaafaaoeia
aaaaoeibalaaaaadaaaaabiaabaappiaajaakkkacaaaaaadabaaaiiaaaaaaaia
acaaffkaafaaaaadabaaaiiaabaappiaacaaaakaalaaaaadadaacciaaaaappia
ajaakkkaafaaaaadaaaachiaabaaoeiaaaaaoekaaeaaaaaeacaaaoiaaaaablia
adaaffiaacaaoeiaabaaaaacaaaaaiiaajaappkabcaaaaaeadaacciaacaaaaia
aaaappiaaiaaaakaacaaaaadaaaaaiiaadaaffiaadaaffiaafaaaaadabaaaiia
abaappiaaaaappiaafaaaaadabaaaiiaadaaaaiaabaappiaafaaaaadadaachia
abaappiaaeaaoekaafaaaaadaaaachiaaaaaoeiaadaaoeiaaeaaaaaeaaaachia
acaabliaaaaappiaaaaaoeiaaeaaaaaeaaaachiaabaaoeiaaeaaoelaaaaaoeia
abaaaaacaaaaciiaajaappkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
kmahaaaaeaaaaaaaolabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaiaaadaagabaaaapaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaapaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaa
aaaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaaadaaaaaa
dgaaaaafecaabaaaaaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaah
bcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaa
aeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaa
egbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaa
agaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaakgikcaaa
aaaaaaaaajaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaamgaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaajaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaa
dcaaaaajocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaaagajbaaa
adaaaaaaehaaaaalicaabaaaabaaaaaaegbabaaaagaaaaaaaghabaaaapaaaaaa
aagabaaaapaaaaaackbabaaaagaaaaaaaaaaaaajicaabaaaacaaaaaaakiacaia
ebaaaaaaadaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakicaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaaakiacaaaadaaaaaabiaaaaaaaaaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaaihcaabaaaadaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaa
aaaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaabfdegejdaaiaaaaaaiaaaaaaaaaaaaaaa
ejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaa
lmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Vector 8 [_Color]
Float 7 [_Distortion]
Vector 3 [_LightColor0]
Float 6 [_Power]
Float 5 [_Scale]
Float 10 [_Shininess]
Vector 4 [_SpecColor]
Vector 9 [_SubColor]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [unity_FogColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Thickness] 2D 2
"ps_2_0
def c11, 2, -1, 0, 1
def c12, 128, 0, 0, 0
dcl t0.xy
dcl t1
dcl t2
dcl t3
dcl_pp t4.xyz
dcl t6.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, t0, s1
texld_pp r1, t0, s0
texld_pp r2, t0, s2
mov r3.x, -t1.w
mov r3.y, -t2.w
mov r3.z, -t3.w
add r3.xyz, r3, c0
nrm_pp r4.xyz, r3
dp3_pp r4.w, c1, c1
rsq_pp r4.w, r4.w
mad_pp r3.xyz, c1, r4.w, r4
mul_pp r5.xyz, r4.w, c1
nrm_pp r6.xyz, r3
mad_pp r3.x, r0.w, c11.x, c11.y
mad_pp r3.y, r0.y, c11.x, c11.y
dp2add_sat_pp r3.w, r3, r3, c11.z
add_pp r3.w, -r3.w, c11.w
rsq_pp r3.w, r3.w
rcp_pp r3.z, r3.w
dp3_pp r0.x, t1, r3
dp3_pp r0.y, t2, r3
dp3_pp r0.z, t3, r3
dp3_pp r0.w, r0, r6
max r4.w, r0.w, c11.z
mov r0.w, c10.x
mul r0.w, r0.w, c12.x
pow r5.w, r4.w, r0.w
mul r0.w, r1.w, r5.w
mul_pp r1.xyz, r1, c8
mov r3.xyz, c3
mul r2.yzw, r3.wzyx, c4.wzyx
mul r2.yzw, r0.w, r2
dp3_pp r0.w, r0, r5
mad_pp r0.xyz, r0, c7.x, r5
dp3_pp r1.w, r4, -r0
max r0.x, r1.w, c11.z
pow r1.w, r0.x, c6.x
mul r1.w, r1.w, c5.x
add r1.w, r1.w, r1.w
max_pp r3.x, r0.w, c11.z
mul_pp r0.xyz, r1, c3
mad r2.yzw, r0.wzyx, r3.x, r2
add_pp r2.yzw, r2, r2
mul r0.w, r2.x, r1.w
mul_pp r3.xyz, r0.w, c9
mad_pp r0.xyz, r0, r3, r2.wzyx
mad_pp r0.xyz, r1, t4, r0
mov_sat r0.w, t6.x
lrp_pp r1.xyz, r0.w, r0, c2
mov_pp r1.w, c11.w
mov_pp oC0, r1

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Thickness] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityFog" 3
"ps_4_0
eefiecedblogddijmonabpmcnhacocgohlanggngabaaaaaahiaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceaahaaaaeaaaaaaanaabaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadecbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaadkbabaaa
acaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaaj
icaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaa
adaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
akiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
akaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaa
egacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
ajaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaapaaaaaibcaabaaa
aaaaaaaaagaabaaaaaaaaaaaagiacaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadcaaaaajocaabaaa
aaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaaaaaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaaihcaabaaa
adaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaajgahbaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaa
aaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Thickness] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityFog" 3
"ps_4_0_level_9_1
eefiecedeecaflhdbgeaajpjpjlilpfmgilopcmbabaaaaaakiamaaaaaeaaaaaa
daaaaaaafmaeaaaakealaaaaheamaaaaebgpgodjceaeaaaaceaeaaaaaaacpppp
liadaaaagmaaaaaaafaadaaaaaaagmaaaaaagmaaadaaceaaaaaagmaaaaaaaaaa
acababaaabacacaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaaaeaaacaaaaaaaaaa
abaaaeaaabaaagaaaaaaaaaaacaaaaaaabaaahaaaaaaaaaaadaaaaaaabaaaiaa
aaaaaaaaaaacppppfbaaaaafajaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadp
fbaaaaafakaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaahlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaaiaadaaaplabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
aaaaoelaabaioekaecaaaaadabaacpiaaaaaoelaaaaioekaecaaaaadacaacpia
aaaaoelaacaioekaabaaaaacadaaabiaabaapplbabaaaaacadaaaciaacaapplb
abaaaaacadaaaeiaadaapplbacaaaaadadaaahiaadaaoeiaagaaoekaceaaaaac
aeaachiaadaaoeiaaiaaaaadaeaaciiaahaaoekaahaaoekaahaaaaacaeaaciia
aeaappiaaeaaaaaeadaachiaahaaoekaaeaappiaaeaaoeiaafaaaaadafaachia
aeaappiaahaaoekaceaaaaacagaachiaadaaoeiaaeaaaaaeadaacbiaaaaappia
ajaaaakaajaaffkaaeaaaaaeadaacciaaaaaffiaajaaaakaajaaffkafkaaaaae
adaadiiaadaaoeiaadaaoeiaajaakkkaacaaaaadadaaciiaadaappibajaappka
ahaaaaacadaaciiaadaappiaagaaaaacadaaceiaadaappiaaiaaaaadaaaacbia
abaaoelaadaaoeiaaiaaaaadaaaacciaacaaoelaadaaoeiaaiaaaaadaaaaceia
adaaoelaadaaoeiaaiaaaaadaaaaciiaaaaaoeiaagaaoeiaalaaaaadaeaaaiia
aaaappiaajaakkkaabaaaaacaaaaaiiaafaaaakaafaaaaadaaaaaiiaaaaappia
akaaaakacaaaaaadafaaaiiaaeaappiaaaaappiaafaaaaadaaaaaiiaabaappia
afaappiaafaaaaadabaachiaabaaoeiaadaaoekaabaaaaacadaaahiaaaaaoeka
afaaaaadacaaaoiaadaabliaabaablkaafaaaaadacaaaoiaaaaappiaacaaoeia
aiaaaaadaaaaciiaaaaaoeiaafaaoeiaaeaaaaaeaaaachiaaaaaoeiaacaakkka
afaaoeiaaiaaaaadabaaciiaaeaaoeiaaaaaoeibalaaaaadaaaaabiaabaappia
ajaakkkacaaaaaadabaaaiiaaaaaaaiaacaaffkaafaaaaadabaaaiiaabaappia
acaaaakaacaaaaadabaaaiiaabaappiaabaappiaalaaaaadadaacbiaaaaappia
ajaakkkaafaaaaadaaaachiaabaaoeiaaaaaoekaaeaaaaaeacaaaoiaaaaablia
adaaaaiaacaaoeiaacaaaaadacaacoiaacaaoeiaacaaoeiaafaaaaadaaaaaiia
acaaaaiaabaappiaafaaaaadadaachiaaaaappiaaeaaoekaaeaaaaaeaaaachia
aaaaoeiaadaaoeiaacaabliaaeaaaaaeaaaachiaabaaoeiaaeaaoelaaaaaoeia
abaaaaacaaaabiiaaaaakklabcaaaaaeabaachiaaaaappiaaaaaoeiaaiaaoeka
abaaaaacabaaciiaajaappkaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefc
eaahaaaaeaaaaaaanaabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadgaaaaaf
bcaabaaaaaaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaa
adaaaaaadgaaaaafecaabaaaaaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
ccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
aeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaed
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaa
aaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaa
kgikcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaa
mgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaajaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaapaaaaaibcaabaaaaaaaaaaaagaabaaaaaaaaaaaagiacaaaaaaaaaaa
ajaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
agaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaa
agajbaaaadaaaaaaaaaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaa
aaaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaaihcaabaaaadaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
alaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
jgahbaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaa
afaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaadaaaaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaa
abaaaaaadcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaadaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaeaeaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapapaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apapaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" }
Vector 10 [_Color]
Float 9 [_Distortion]
Vector 5 [_LightColor0]
Float 8 [_Power]
Float 7 [_Scale]
Float 12 [_Shininess]
Vector 6 [_SpecColor]
Vector 11 [_SubColor]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 4 [unity_DynamicLightmap_HDR]
Vector 2 [unity_FogColor]
Vector 3 [unity_FogParams]
SetTexture 0 [unity_DynamicLightmap] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_Thickness] 2D 3
"ps_3_0
def c13, 2, -1, 0, 1
def c14, 128, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4_pp v4.xyz
dcl_texcoord6 v5.x
dcl_texcoord7 v6.zw
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
mov r0.x, v1.w
mov r0.y, v2.w
mov r0.z, v3.w
add r0.xyz, -r0, c0
nrm_pp r1.xyz, r0
dp3_pp r0.x, c1, c1
rsq_pp r0.x, r0.x
mad_pp r0.yzw, c1.xxyz, r0.x, r1.xxyz
mul_pp r2.xyz, r0.x, c1
nrm_pp r3.xyz, r0.yzww
texld_pp r0, v0, s2
mad_pp r0.xy, r0.wyzw, c13.x, c13.y
dp2add_sat_pp r0.w, r0, r0, c13.z
add_pp r0.w, -r0.w, c13.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
dp3_pp r4.x, v1, r0
dp3_pp r4.y, v2, r0
dp3_pp r4.z, v3, r0
dp3_pp r0.x, r4, r3
max r1.w, r0.x, c13.z
mov r0.x, c12.x
mul r0.x, r0.x, c14.x
pow r2.w, r1.w, r0.x
texld_pp r0, v0, s1
mul r0.w, r0.w, r2.w
mul_pp r0.xyz, r0, c10
mov r3.xyz, c5
mul r3.xyz, r3, c6
mul r3.xyz, r0.w, r3
dp3_pp r0.w, r4, r2
mad_pp r2.xyz, r4, c9.x, r2
dp3_pp r1.x, r1, -r2
max r2.x, r1.x, c13.z
pow r1.x, r2.x, c8.x
mov r1.z, c13.z
dp2add r1.x, r1.x, c7.x, r1.z
max_pp r1.y, r0.w, c13.z
mul_pp r2.xyz, r0, c5
mad r1.yzw, r2.xxyz, r1.y, r3.xxyz
add_pp r1.yzw, r1, r1
texld_pp r3, v0, s3
mul r0.w, r1.x, r3.x
mul_pp r3.xyz, r0.w, c11
mad_pp r1.xyz, r2, r3, r1.yzww
mad_pp r1.xyz, r0, v4, r1
texld_pp r2, v6.zwzw, s0
mul_pp r0.w, r2.w, c4.x
mul_pp r2.xyz, r2, r0.w
log_pp r3.x, r2.x
log_pp r3.y, r2.y
log_pp r3.z, r2.z
mul_pp r2.xyz, r3, c4.y
exp_pp r3.x, r2.x
exp_pp r3.y, r2.y
exp_pp r3.z, r2.z
mad_pp r0.xyz, r0, r3, r1
add r0.xyz, r0, -c2
mul r0.w, c3.y, v5.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c2
mov_pp oC0.w, c13.w

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Thickness] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [unity_DynamicLightmap] 2D 0
ConstBuffer "$Globals" 224
Vector 80 [unity_DynamicLightmap_HDR]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityFog" 3
"ps_4_0
eefiecednbpljncbdliefdgcplpndmncadlfpbehabaaaaaameajaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcheaiaaaaeaaaaaaabnacaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadmcbabaaaagaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaadkbabaaa
acaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaaj
icaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaa
adaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
akiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
akaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaa
egacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
ajaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaapaaaaaibcaabaaa
aaaaaaaaagaabaaaaaaaaaaaagiacaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadcaaaaajocaabaaa
aaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaaaaaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaaihcaabaaa
adaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaajgahbaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaagaaaaaaeghobaaaadaaaaaaaagabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaacaaaaaaakiacaaaaaaaaaaa
afaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaa
cpaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaabjaaaaafhcaabaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaadaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaackbabaaa
abaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaadaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Vector 8 [_Color]
Float 7 [_Distortion]
Vector 3 [_LightColor0]
Float 6 [_Power]
Float 5 [_Scale]
Float 10 [_Shininess]
Vector 4 [_SpecColor]
Vector 9 [_SubColor]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [unity_FogColor]
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_Thickness] 2D 3
"ps_2_0
def c11, 2, -1, 0, 1
def c12, 128, 0, 0, 0
dcl t0.xy
dcl t1
dcl t2
dcl t3
dcl_pp t4.xyz
dcl_pp t5
dcl t6.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texld_pp r0, t0, s2
texld_pp r1, t0, s1
texldp_pp r2, t5, s0
texld_pp r3, t0, s3
mov r4.x, -t1.w
mov r4.y, -t2.w
mov r4.z, -t3.w
add r4.xyz, r4, c0
nrm_pp r5.xyz, r4
dp3_pp r5.w, c1, c1
rsq_pp r5.w, r5.w
mad_pp r4.xyz, c1, r5.w, r5
mul_pp r6.xyz, r5.w, c1
nrm_pp r7.xyz, r4
mad_pp r4.x, r0.w, c11.x, c11.y
mad_pp r4.y, r0.y, c11.x, c11.y
dp2add_sat_pp r4.w, r4, r4, c11.z
add_pp r4.w, -r4.w, c11.w
rsq_pp r4.w, r4.w
rcp_pp r4.z, r4.w
dp3_pp r0.x, t1, r4
dp3_pp r0.y, t2, r4
dp3_pp r0.z, t3, r4
dp3_pp r0.w, r0, r7
max r5.w, r0.w, c11.z
mov r0.w, c10.x
mul r0.w, r0.w, c12.x
pow r6.w, r5.w, r0.w
mul r0.w, r1.w, r6.w
mul_pp r1.xyz, r1, c8
mov r4.xyz, c3
mul r2.yzw, r4.wzyx, c4.wzyx
mul r2.yzw, r0.w, r2
dp3_pp r0.w, r0, r6
mad_pp r0.xyz, r0, c7.x, r6
dp3_pp r1.w, r5, -r0
max r0.x, r1.w, c11.z
pow r1.w, r0.x, c6.x
mul r1.w, r1.w, c5.x
max_pp r3.y, r0.w, c11.z
mul_pp r0.xyz, r1, c3
mad r2.yzw, r0.wzyx, r3.y, r2
add r0.w, r2.x, r2.x
mul r1.w, r1.w, r0.w
mul r1.w, r3.x, r1.w
mul_pp r3.xyz, r1.w, c9
mul_pp r0.xyz, r0, r3
mad_pp r0.xyz, r2.wzyx, r0.w, r0
mad_pp r0.xyz, r1, t4, r0
mov_sat r0.w, t6.x
lrp_pp r1.xyz, r0.w, r0, c2
mov_pp r1.w, c11.w
mov_pp oC0, r1

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Thickness] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityFog" 3
"ps_4_0
eefiecedgcohcicgdcigeokffpiionipohljpabmabaaaaaadaajaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcoaahaaaaeaaaaaaapiabaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadlcbabaaaagaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaadkbabaaa
acaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaaj
icaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaa
adaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
akiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
akaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaa
egacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
ajaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadcaaaaajocaabaaa
aaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaaaoaaaaah
dcaabaaaadaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaah
icaabaaaabaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaaihcaabaaaadaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaa
aaaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaaaaaaaaadgcaaaaf
icaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" }
Vector 10 [_Color]
Float 9 [_Distortion]
Vector 5 [_LightColor0]
Float 8 [_Power]
Float 7 [_Scale]
Float 12 [_Shininess]
Vector 6 [_SpecColor]
Vector 11 [_SubColor]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 4 [unity_DynamicLightmap_HDR]
Vector 2 [unity_FogColor]
Vector 3 [unity_FogParams]
SetTexture 0 [unity_DynamicLightmap] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
SetTexture 4 [_Thickness] 2D 4
"ps_3_0
def c13, 2, -1, 0, 1
def c14, 128, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4_pp v4.xyz
dcl_texcoord5 v5
dcl_texcoord6 v6.x
dcl_texcoord7 v7.zw
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
mov r0.x, v1.w
mov r0.y, v2.w
mov r0.z, v3.w
add r0.xyz, -r0, c0
nrm_pp r1.xyz, r0
dp3_pp r0.x, c1, c1
rsq_pp r0.x, r0.x
mad_pp r0.yzw, c1.xxyz, r0.x, r1.xxyz
mul_pp r2.xyz, r0.x, c1
nrm_pp r3.xyz, r0.yzww
texld_pp r0, v0, s3
mad_pp r0.xy, r0.wyzw, c13.x, c13.y
dp2add_sat_pp r0.w, r0, r0, c13.z
add_pp r0.w, -r0.w, c13.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
dp3_pp r4.x, v1, r0
dp3_pp r4.y, v2, r0
dp3_pp r4.z, v3, r0
dp3_pp r0.x, r4, r3
max r1.w, r0.x, c13.z
mov r0.x, c12.x
mul r0.x, r0.x, c14.x
pow r2.w, r1.w, r0.x
texld_pp r0, v0, s2
mul r0.w, r0.w, r2.w
mul_pp r0.xyz, r0, c10
mov r3.xyz, c5
mul r3.xyz, r3, c6
mul r3.xyz, r0.w, r3
dp3_pp r0.w, r4, r2
mad_pp r2.xyz, r4, c9.x, r2
dp3_pp r1.x, r1, -r2
max r2.x, r1.x, c13.z
pow r1.x, r2.x, c8.x
mul r1.x, r1.x, c7.x
max_pp r1.y, r0.w, c13.z
mul_pp r2.xyz, r0, c5
mad r1.yzw, r2.xxyz, r1.y, r3.xxyz
texldp_pp r3, v5, s1
add r0.w, r3.x, r3.x
mul r1.x, r1.x, r0.w
texld_pp r3, v0, s4
mul r1.x, r1.x, r3.x
mul_pp r3.xyz, r1.x, c11
mul_pp r2.xyz, r2, r3
mad_pp r1.xyz, r1.yzww, r0.w, r2
mad_pp r1.xyz, r0, v4, r1
texld_pp r2, v7.zwzw, s0
mul_pp r0.w, r2.w, c4.x
mul_pp r2.xyz, r2, r0.w
log_pp r3.x, r2.x
log_pp r3.y, r2.y
log_pp r3.z, r2.z
mul_pp r2.xyz, r3, c4.y
exp_pp r3.x, r2.x
exp_pp r3.y, r2.y
exp_pp r3.z, r2.z
mad_pp r0.xyz, r0, r3, r1
add r0.xyz, r0, -c2
mul r0.w, c3.y, v6.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c2
mov_pp oC0.w, c13.w

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_ON" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Thickness] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_ShadowMapTexture] 2D 1
SetTexture 4 [unity_DynamicLightmap] 2D 0
ConstBuffer "$Globals" 224
Vector 80 [unity_DynamicLightmap_HDR]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityFog" 3
"ps_4_0
eefiecedapbjgmgbgdhneghdmlhlmmfcbkpjjomaabaaaaaahmakaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaomaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapalaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcbeajaaaaeaaaaaaaefacaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadlcbabaaaagaaaaaagcbaaaadmcbabaaaahaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaadkbabaaa
acaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaaj
icaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaa
adaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
akiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
akaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaa
egacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
ajaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadcaaaaajocaabaaa
aaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaaaoaaaaah
dcaabaaaadaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaaaaaaaah
icaabaaaabaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaaihcaabaaaadaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaa
aaaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaahaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaacaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaacpaaaaafhcaabaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
fgifcaaaaaaaaaaaafaaaaaabjaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
adaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaackbabaaaabaaaaaabkiacaaa
adaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
ddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaak
hccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Thickness] 2D 2
SetTexture 2 [_BumpMap] 2D 1
SetTexture 15 [_ShadowMapTexture] 2D 15
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityFog" 4
"ps_4_0_level_9_1
eefiecedpafbgnmghfndbaaechpdnmaeldfnlghaabaaaaaaceaoaaaaafaaaaaa
deaaaaaamiaeaaaapiamaaaaaianaaaapaanaaaaebgpgodjimaeaaaaimaeaaaa
aaacppppbaaeaaaahmaaaaaaagaadeaaaaaahmaaaaaahmaaaeaaceaaaaaahmaa
apapaaaaaaaaabaaacabacaaabacadaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaa
aeaaacaaaaaaaaaaabaaaeaaabaaagaaaaaaaaaaacaaaaaaabaaahaaaaaaaaaa
adaabiaaabaaaiaaaaaaaaaaaeaaaaaaabaaajaaaaaaaaaaaaacppppfbaaaaaf
akaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafalaaapkaaaaaaaed
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaaplabpaaaaac
aaaaaaiaaeaachlabpaaaaacaaaaaaiaafaacplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkaecaaaaadaaaacpiaaaaaoelaacaioekaecaaaaadabaacpiaaaaaoela
abaioekaecaaaaadacaacpiaafaaoelaaaaioekaecaaaaadadaacpiaaaaaoela
adaioekaabaaaaacaeaaabiaabaapplbabaaaaacaeaaaciaacaapplbabaaaaac
aeaaaeiaadaapplbacaaaaadaeaaahiaaeaaoeiaagaaoekaceaaaaacafaachia
aeaaoeiaaiaaaaadafaaciiaahaaoekaahaaoekaahaaaaacafaaciiaafaappia
aeaaaaaeaeaachiaahaaoekaafaappiaafaaoeiaafaaaaadagaachiaafaappia
ahaaoekaceaaaaacahaachiaaeaaoeiaaeaaaaaeaeaacbiaaaaappiaakaaaaka
akaaffkaaeaaaaaeaeaacciaaaaaffiaakaaaakaakaaffkafkaaaaaeaeaadiia
aeaaoeiaaeaaoeiaakaakkkaacaaaaadaeaaciiaaeaappibakaappkaahaaaaac
aeaaciiaaeaappiaagaaaaacaeaaceiaaeaappiaaiaaaaadaaaacbiaabaaoela
aeaaoeiaaiaaaaadaaaacciaacaaoelaaeaaoeiaaiaaaaadaaaaceiaadaaoela
aeaaoeiaaiaaaaadaaaaciiaaaaaoeiaahaaoeiaalaaaaadafaaaiiaaaaappia
akaakkkaabaaaaacaaaaaiiaafaaaakaafaaaaadaaaaaiiaaaaappiaalaaaaka
caaaaaadagaaaiiaafaappiaaaaappiaafaaaaadaaaaaiiaabaappiaagaappia
afaaaaadabaachiaabaaoeiaadaaoekaabaaaaacaeaaahiaaaaaoekaafaaaaad
acaaaoiaaeaabliaabaablkaafaaaaadacaaaoiaaaaappiaacaaoeiaaiaaaaad
aaaaciiaaaaaoeiaagaaoeiaaeaaaaaeaaaachiaaaaaoeiaacaakkkaagaaoeia
aiaaaaadabaaciiaafaaoeiaaaaaoeibalaaaaadaaaaabiaabaappiaakaakkka
caaaaaadabaaaiiaaaaaaaiaacaaffkaafaaaaadabaaaiiaabaappiaacaaaaka
alaaaaadadaacciaaaaappiaakaakkkaafaaaaadaaaachiaabaaoeiaaaaaoeka
aeaaaaaeacaaaoiaaaaabliaadaaffiaacaaoeiaabaaaaacaaaaaiiaakaappka
bcaaaaaeadaacciaacaaaaiaaaaappiaaiaaaakaacaaaaadaaaaaiiaadaaffia
adaaffiaafaaaaadabaaaiiaabaappiaaaaappiaafaaaaadabaaaiiaadaaaaia
abaappiaafaaaaadadaachiaabaappiaaeaaoekaafaaaaadaaaachiaaaaaoeia
adaaoeiaaeaaaaaeaaaachiaacaabliaaaaappiaaaaaoeiaaeaaaaaeaaaachia
abaaoeiaaeaaoelaaaaaoeiaabaaaaacaaaabiiaaaaakklabcaaaaaeabaachia
aaaappiaaaaaoeiaajaaoekaabaaaaacabaaciiaakaappkaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcciaiaaaaeaaaaaaaakacaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabjaaaaaafjaaaaaeegiocaaa
aeaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaiaaadaagabaaaapaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaapaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaa
dgaaaaafbcaabaaaaaaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaaaaaaaaa
dkbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaadkbabaaaaeaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaa
baaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaah
ecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaa
aaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaadaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaa
aeaaaaaakgikcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaajaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaagaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaa
aaaaaaaaagajbaaaadaaaaaaehaaaaalicaabaaaabaaaaaaegbabaaaagaaaaaa
aghabaaaapaaaaaaaagabaaaapaaaaaackbabaaaagaaaaaaaaaaaaajicaabaaa
acaaaaaaakiacaiaebaaaaaaadaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaak
icaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaaakiacaaaadaaaaaa
biaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaai
hcaabaaaadaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaajgahbaaaaaaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaeaaaaaa
aaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaeaaaaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabfdegejdaaiaaaaaa
iaaaaaaaaaaaaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaeaeaaaa
neaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaaneaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaa
neaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Blend One One
  GpuProgramID 102649
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * TANGENT.xyz));
  vec3 tmpvar_7;
  tmpvar_7 = (((tmpvar_4.yzx * tmpvar_6.zxy) - (tmpvar_4.zxy * tmpvar_6.yzx)) * TANGENT.w);
  vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_6.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_4.x;
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_6.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_4.y;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_6.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_4.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz * _Color.xyz);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD4;
  vec3 tmpvar_7;
  tmpvar_7 = (_LightMatrix0 * tmpvar_6).xyz;
  float tmpvar_8;
  tmpvar_8 = texture2D (_LightTexture0, vec2(dot (tmpvar_7, tmpvar_7))).w;
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4)));
  float tmpvar_12;
  tmpvar_12 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_11 + tmpvar_10)))
  ), (_Shininess * 128.0)) * tmpvar_3.w);
  c_9.xyz = (((
    ((tmpvar_4 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_11)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_12)
  ) * (tmpvar_8 * 2.0)) + ((tmpvar_4 * _LightColor0.xyz) * (
    (((tmpvar_8 * 2.0) * (pow (
      max (0.0, dot (tmpvar_10, -((tmpvar_11 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_9.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_12) * tmpvar_8);
  c_2.xyz = c_9.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v3, c10, c10.zwzw
dp4 oT4.x, c4, v0
dp4 oT4.y, c5, v0
dp4 oT4.z, c6, v0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, v2.y, c8.zxyw
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.y
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.z
mov oT3.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhkklgpgkofkaceldikobcgbcjbdcelfmabaaaaaageahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpglgalnhccmeacfndpfaaihiclmchaanabaaaaaakaakaaaaaeaaaaaa
daaaaaaagiadaaaapaaiaaaaoiajaaaaebgpgodjdaadaaaadaadaaaaaaacpopp
oeacaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaabbaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeaeaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaapia
aaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaafaaaaadaaaaahiaabaaffjaahaamjkaaeaaaaaeaaaaahiaagaamjka
abaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaamjkaabaakkjaaaaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadaaaaahia
aaaappiaaaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaadabaaaciaacaaaaja
akaaaakaafaaaaadabaaaeiaacaaaajaalaaaakaafaaaaadabaaabiaacaaaaja
amaaaakaafaaaaadacaaaciaacaaffjaakaaffkaafaaaaadacaaaeiaacaaffja
alaaffkaafaaaaadacaaabiaacaaffjaamaaffkaacaaaaadabaaahiaabaaoeia
acaaoeiaafaaaaadacaaaciaacaakkjaakaakkkaafaaaaadacaaaeiaacaakkja
alaakkkaafaaaaadacaaabiaacaakkjaamaakkkaacaaaaadabaaahiaabaaoeia
acaaoeiaaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadabaaahiaaaaappiaabaaoeiaafaaaaadacaaahiaaaaaoeiaabaaoeia
aeaaaaaeacaaahiaabaanciaaaaamjiaacaaoeibafaaaaadacaaahiaacaaoeia
abaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoaabaaffiaabaaaaac
acaaaboaaaaaaaiaabaaaaacadaaaboaaaaaffiaabaaaaacacaaacoaacaaffia
abaaaaacadaaacoaacaakkiaabaaaaacacaaaeoaabaakkiaabaaaaacadaaaeoa
abaaaaiappppaaaafdeieefciaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaa
aaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
oaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * TANGENT.xyz));
  vec3 tmpvar_7;
  tmpvar_7 = (((tmpvar_4.yzx * tmpvar_6.zxy) - (tmpvar_4.zxy * tmpvar_6.yzx)) * TANGENT.w);
  vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_6.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_4.x;
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_6.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_4.y;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_6.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_4.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz * _Color.xyz);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  vec3 tmpvar_8;
  tmpvar_8 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_9;
  tmpvar_9 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_8 + tmpvar_7)))
  ), (_Shininess * 128.0)) * tmpvar_3.w);
  c_6.xyz = (((
    ((tmpvar_4 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_8)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_9)
  ) * 2.0) + ((tmpvar_4 * _LightColor0.xyz) * (
    ((2.0 * (pow (
      max (0.0, dot (tmpvar_7, -((tmpvar_8 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_6.w = ((_LightColor0.w * _SpecColor.w) * tmpvar_9);
  c_2.xyz = c_6.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v3, c10, c10.zwzw
dp4 oT4.x, c4, v0
dp4 oT4.y, c5, v0
dp4 oT4.z, c6, v0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, v2.y, c8.zxyw
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.y
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.z
mov oT3.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedfbapkfoboonodmpjlcbjjcbnipcbmlppabaaaaaageahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaae
egiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedhipogbafdpddbmnochkljojlpiegcajfabaaaaaakaakaaaaaeaaaaaa
daaaaaaagiadaaaapaaiaaaaoiajaaaaebgpgodjdaadaaaadaadaaaaaaacpopp
oeacaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaanaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeaeaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaapia
aaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaafaaaaadaaaaahiaabaaffjaahaamjkaaeaaaaaeaaaaahiaagaamjka
abaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaamjkaabaakkjaaaaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadaaaaahia
aaaappiaaaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaadabaaaciaacaaaaja
akaaaakaafaaaaadabaaaeiaacaaaajaalaaaakaafaaaaadabaaabiaacaaaaja
amaaaakaafaaaaadacaaaciaacaaffjaakaaffkaafaaaaadacaaaeiaacaaffja
alaaffkaafaaaaadacaaabiaacaaffjaamaaffkaacaaaaadabaaahiaabaaoeia
acaaoeiaafaaaaadacaaaciaacaakkjaakaakkkaafaaaaadacaaaeiaacaakkja
alaakkkaafaaaaadacaaabiaacaakkjaamaakkkaacaaaaadabaaahiaabaaoeia
acaaoeiaaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadabaaahiaaaaappiaabaaoeiaafaaaaadacaaahiaaaaaoeiaabaaoeia
aeaaaaaeacaaahiaabaanciaaaaamjiaacaaoeibafaaaaadacaaahiaacaaoeia
abaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoaabaaffiaabaaaaac
acaaaboaaaaaaaiaabaaaaacadaaaboaaaaaffiaabaaaaacacaaacoaacaaffia
abaaaaacadaaacoaacaakkiaabaaaaacacaaaeoaabaakkiaabaaaaacadaaaeoa
abaaaaiappppaaaafdeieefciaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
oaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * TANGENT.xyz));
  vec3 tmpvar_7;
  tmpvar_7 = (((tmpvar_4.yzx * tmpvar_6.zxy) - (tmpvar_4.zxy * tmpvar_6.yzx)) * TANGENT.w);
  vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_6.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_4.x;
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_6.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_4.y;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_6.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_4.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz * _Color.xyz);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD4;
  vec4 tmpvar_7;
  tmpvar_7 = (_LightMatrix0 * tmpvar_6);
  float tmpvar_8;
  tmpvar_8 = ((float(
    (tmpvar_7.z > 0.0)
  ) * texture2D (_LightTexture0, (
    (tmpvar_7.xy / tmpvar_7.w)
   + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_7.xyz, tmpvar_7.xyz))).w);
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4)));
  float tmpvar_12;
  tmpvar_12 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_11 + tmpvar_10)))
  ), (_Shininess * 128.0)) * tmpvar_3.w);
  c_9.xyz = (((
    ((tmpvar_4 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_11)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_12)
  ) * (tmpvar_8 * 2.0)) + ((tmpvar_4 * _LightColor0.xyz) * (
    (((tmpvar_8 * 2.0) * (pow (
      max (0.0, dot (tmpvar_10, -((tmpvar_11 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_9.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_12) * tmpvar_8);
  c_2.xyz = c_9.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v3, c10, c10.zwzw
dp4 oT4.x, c4, v0
dp4 oT4.y, c5, v0
dp4 oT4.z, c6, v0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, v2.y, c8.zxyw
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.y
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.z
mov oT3.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhkklgpgkofkaceldikobcgbcjbdcelfmabaaaaaageahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpglgalnhccmeacfndpfaaihiclmchaanabaaaaaakaakaaaaaeaaaaaa
daaaaaaagiadaaaapaaiaaaaoiajaaaaebgpgodjdaadaaaadaadaaaaaaacpopp
oeacaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaabbaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeaeaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaapia
aaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaafaaaaadaaaaahiaabaaffjaahaamjkaaeaaaaaeaaaaahiaagaamjka
abaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaamjkaabaakkjaaaaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadaaaaahia
aaaappiaaaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaadabaaaciaacaaaaja
akaaaakaafaaaaadabaaaeiaacaaaajaalaaaakaafaaaaadabaaabiaacaaaaja
amaaaakaafaaaaadacaaaciaacaaffjaakaaffkaafaaaaadacaaaeiaacaaffja
alaaffkaafaaaaadacaaabiaacaaffjaamaaffkaacaaaaadabaaahiaabaaoeia
acaaoeiaafaaaaadacaaaciaacaakkjaakaakkkaafaaaaadacaaaeiaacaakkja
alaakkkaafaaaaadacaaabiaacaakkjaamaakkkaacaaaaadabaaahiaabaaoeia
acaaoeiaaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadabaaahiaaaaappiaabaaoeiaafaaaaadacaaahiaaaaaoeiaabaaoeia
aeaaaaaeacaaahiaabaanciaaaaamjiaacaaoeibafaaaaadacaaahiaacaaoeia
abaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoaabaaffiaabaaaaac
acaaaboaaaaaaaiaabaaaaacadaaaboaaaaaffiaabaaaaacacaaacoaacaaffia
abaaaaacadaaacoaacaakkiaabaaaaacacaaaeoaabaakkiaabaaaaacadaaaeoa
abaaaaiappppaaaafdeieefciaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaa
aaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
oaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * TANGENT.xyz));
  vec3 tmpvar_7;
  tmpvar_7 = (((tmpvar_4.yzx * tmpvar_6.zxy) - (tmpvar_4.zxy * tmpvar_6.yzx)) * TANGENT.w);
  vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_6.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_4.x;
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_6.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_4.y;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_6.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_4.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz * _Color.xyz);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD4;
  vec3 tmpvar_7;
  tmpvar_7 = (_LightMatrix0 * tmpvar_6).xyz;
  float tmpvar_8;
  tmpvar_8 = (texture2D (_LightTextureB0, vec2(dot (tmpvar_7, tmpvar_7))).w * textureCube (_LightTexture0, tmpvar_7).w);
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4)));
  float tmpvar_12;
  tmpvar_12 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_11 + tmpvar_10)))
  ), (_Shininess * 128.0)) * tmpvar_3.w);
  c_9.xyz = (((
    ((tmpvar_4 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_11)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_12)
  ) * (tmpvar_8 * 2.0)) + ((tmpvar_4 * _LightColor0.xyz) * (
    (((tmpvar_8 * 2.0) * (pow (
      max (0.0, dot (tmpvar_10, -((tmpvar_11 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_9.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_12) * tmpvar_8);
  c_2.xyz = c_9.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v3, c10, c10.zwzw
dp4 oT4.x, c4, v0
dp4 oT4.y, c5, v0
dp4 oT4.z, c6, v0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, v2.y, c8.zxyw
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.y
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.z
mov oT3.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhkklgpgkofkaceldikobcgbcjbdcelfmabaaaaaageahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpglgalnhccmeacfndpfaaihiclmchaanabaaaaaakaakaaaaaeaaaaaa
daaaaaaagiadaaaapaaiaaaaoiajaaaaebgpgodjdaadaaaadaadaaaaaaacpopp
oeacaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaabbaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeaeaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaapia
aaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaafaaaaadaaaaahiaabaaffjaahaamjkaaeaaaaaeaaaaahiaagaamjka
abaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaamjkaabaakkjaaaaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadaaaaahia
aaaappiaaaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaadabaaaciaacaaaaja
akaaaakaafaaaaadabaaaeiaacaaaajaalaaaakaafaaaaadabaaabiaacaaaaja
amaaaakaafaaaaadacaaaciaacaaffjaakaaffkaafaaaaadacaaaeiaacaaffja
alaaffkaafaaaaadacaaabiaacaaffjaamaaffkaacaaaaadabaaahiaabaaoeia
acaaoeiaafaaaaadacaaaciaacaakkjaakaakkkaafaaaaadacaaaeiaacaakkja
alaakkkaafaaaaadacaaabiaacaakkjaamaakkkaacaaaaadabaaahiaabaaoeia
acaaoeiaaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadabaaahiaaaaappiaabaaoeiaafaaaaadacaaahiaaaaaoeiaabaaoeia
aeaaaaaeacaaahiaabaanciaaaaamjiaacaaoeibafaaaaadacaaahiaacaaoeia
abaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoaabaaffiaabaaaaac
acaaaboaaaaaaaiaabaaaaacadaaaboaaaaaffiaabaaaaacacaaacoaacaaffia
abaaaaacadaaacoaacaakkiaabaaaaacacaaaeoaabaakkiaabaaaaacadaaaeoa
abaaaaiappppaaaafdeieefciaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaa
aaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
oaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * TANGENT.xyz));
  vec3 tmpvar_7;
  tmpvar_7 = (((tmpvar_4.yzx * tmpvar_6.zxy) - (tmpvar_4.zxy * tmpvar_6.yzx)) * TANGENT.w);
  vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_6.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_4.x;
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_6.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_4.y;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_6.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_4.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz * _Color.xyz);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD4;
  float tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, (_LightMatrix0 * tmpvar_6).xy).w;
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_8;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_11;
  tmpvar_11 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_10 + tmpvar_9)))
  ), (_Shininess * 128.0)) * tmpvar_3.w);
  c_8.xyz = (((
    ((tmpvar_4 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_10)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_11)
  ) * (tmpvar_7 * 2.0)) + ((tmpvar_4 * _LightColor0.xyz) * (
    (((tmpvar_7 * 2.0) * (pow (
      max (0.0, dot (tmpvar_9, -((tmpvar_10 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_8.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_11) * tmpvar_7);
  c_2.xyz = c_8.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v3, c10, c10.zwzw
dp4 oT4.x, c4, v0
dp4 oT4.y, c5, v0
dp4 oT4.z, c6, v0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, v2.y, c8.zxyw
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.y
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.z
mov oT3.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhkklgpgkofkaceldikobcgbcjbdcelfmabaaaaaageahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpglgalnhccmeacfndpfaaihiclmchaanabaaaaaakaakaaaaaeaaaaaa
daaaaaaagiadaaaapaaiaaaaoiajaaaaebgpgodjdaadaaaadaadaaaaaaacpopp
oeacaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaabbaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeaeaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaapia
aaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaafaaaaadaaaaahiaabaaffjaahaamjkaaeaaaaaeaaaaahiaagaamjka
abaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaamjkaabaakkjaaaaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadaaaaahia
aaaappiaaaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaadabaaaciaacaaaaja
akaaaakaafaaaaadabaaaeiaacaaaajaalaaaakaafaaaaadabaaabiaacaaaaja
amaaaakaafaaaaadacaaaciaacaaffjaakaaffkaafaaaaadacaaaeiaacaaffja
alaaffkaafaaaaadacaaabiaacaaffjaamaaffkaacaaaaadabaaahiaabaaoeia
acaaoeiaafaaaaadacaaaciaacaakkjaakaakkkaafaaaaadacaaaeiaacaakkja
alaakkkaafaaaaadacaaabiaacaakkjaamaakkkaacaaaaadabaaahiaabaaoeia
acaaoeiaaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadabaaahiaaaaappiaabaaoeiaafaaaaadacaaahiaaaaaoeiaabaaoeia
aeaaaaaeacaaahiaabaanciaaaaamjiaacaaoeibafaaaaadacaaahiaacaaoeia
abaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoaabaaffiaabaaaaac
acaaaboaaaaaaaiaabaaaaacadaaaboaaaaaffiaabaaaaacacaaacoaacaaffia
abaaaaacadaaacoaacaakkiaabaaaaacacaaaeoaabaakkiaabaaaaacadaaaeoa
abaaaaiappppaaaafdeieefciaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaa
aaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
oaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "POINT" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
  vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * TANGENT.w);
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_5.x;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_7.y;
  tmpvar_10.y = tmpvar_8.y;
  tmpvar_10.z = tmpvar_5.y;
  vec3 tmpvar_11;
  tmpvar_11.x = tmpvar_7.z;
  tmpvar_11.y = tmpvar_8.z;
  tmpvar_11.z = tmpvar_5.z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD6 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz * _Color.xyz);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD4;
  vec3 tmpvar_7;
  tmpvar_7 = (_LightMatrix0 * tmpvar_6).xyz;
  float tmpvar_8;
  tmpvar_8 = texture2D (_LightTexture0, vec2(dot (tmpvar_7, tmpvar_7))).w;
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4)));
  float tmpvar_12;
  tmpvar_12 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_11 + tmpvar_10)))
  ), (_Shininess * 128.0)) * tmpvar_3.w);
  c_9.xyz = (((
    ((tmpvar_4 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_11)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_12)
  ) * (tmpvar_8 * 2.0)) + ((tmpvar_4 * _LightColor0.xyz) * (
    (((tmpvar_8 * 2.0) * (pow (
      max (0.0, dot (tmpvar_10, -((tmpvar_11 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_9.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_12) * tmpvar_8);
  c_2.xyz = mix (vec3(0.0, 0.0, 0.0), c_9.xyz, vec3(clamp (xlv_TEXCOORD6, 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v3, c11, c11.zwzw
dp4 oT4.x, c4, v0
dp4 oT4.y, c5, v0
dp4 oT4.z, c6, v0
dp4 r0.x, c2, v0
mul r0.y, r0.x, c10.y
mov oPos.z, r0.x
exp oT6.x, -r0.y
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, v2.y, c8.zxyw
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.y
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.z
mov oT3.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedlbcpalnfemlbfhjcmggdalkcbapfjmpeabaaaaaaoeahaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoiafaaaaeaaaabaa
hkabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
adaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaa
aaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedkglfhcokocnkddobjoldacafedgkbhnbabaaaaaaeialaaaaaeaaaaaa
daaaaaaajaadaaaaiaajaaaahiakaaaaebgpgodjfiadaaaafiadaaaaaaacpopp
aaadaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaabbaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahia
aaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaeaaahoaajaaoekaaaaappja
aaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaakkiaanaaffka
aoaaaaacaaaaaeoaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaafaaaaadaaaaahiaabaaffjaahaamjkaaeaaaaae
aaaaahiaagaamjkaabaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaamjkaabaakkja
aaaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadaaaaahiaaaaappiaaaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaad
abaaaciaacaaaajaakaaaakaafaaaaadabaaaeiaacaaaajaalaaaakaafaaaaad
abaaabiaacaaaajaamaaaakaafaaaaadacaaaciaacaaffjaakaaffkaafaaaaad
acaaaeiaacaaffjaalaaffkaafaaaaadacaaabiaacaaffjaamaaffkaacaaaaad
abaaahiaabaaoeiaacaaoeiaafaaaaadacaaaciaacaakkjaakaakkkaafaaaaad
acaaaeiaacaakkjaalaakkkaafaaaaadacaaabiaacaakkjaamaakkkaacaaaaad
abaaahiaabaaoeiaacaaoeiaaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaac
aaaaaiiaaaaappiaafaaaaadabaaahiaaaaappiaabaaoeiaafaaaaadacaaahia
aaaaoeiaabaaoeiaaeaaaaaeacaaahiaabaanciaaaaamjiaacaaoeibafaaaaad
acaaahiaacaaoeiaabaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoa
abaaffiaabaaaaacacaaaboaaaaaaaiaabaaaaacadaaaboaaaaaffiaabaaaaac
acaaacoaacaaffiaabaaaaacadaaacoaacaakkiaabaaaaacacaaaeoaabaakkia
abaaaaacadaaaeoaabaaaaiappppaaaafdeieefcoiafaaaaeaaaabaahkabaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
eccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaa
bkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
bbaaaaaaogikcaaaaaaaaaaabbaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaaacaaaaaa
bkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaajgiecaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaamaaaaaa
agbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaa
abaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaa
abaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaa
acaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaaaaaaaaaa
dgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaaadaaaaaa
akaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaf
cccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaa
acaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaagaaaaaa
aaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
  vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * TANGENT.w);
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_5.x;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_7.y;
  tmpvar_10.y = tmpvar_8.y;
  tmpvar_10.z = tmpvar_5.y;
  vec3 tmpvar_11;
  tmpvar_11.x = tmpvar_7.z;
  tmpvar_11.y = tmpvar_8.z;
  tmpvar_11.z = tmpvar_5.z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD6 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz * _Color.xyz);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  vec3 tmpvar_8;
  tmpvar_8 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_9;
  tmpvar_9 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_8 + tmpvar_7)))
  ), (_Shininess * 128.0)) * tmpvar_3.w);
  c_6.xyz = (((
    ((tmpvar_4 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_8)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_9)
  ) * 2.0) + ((tmpvar_4 * _LightColor0.xyz) * (
    ((2.0 * (pow (
      max (0.0, dot (tmpvar_7, -((tmpvar_8 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_6.w = ((_LightColor0.w * _SpecColor.w) * tmpvar_9);
  c_2.xyz = mix (vec3(0.0, 0.0, 0.0), c_6.xyz, vec3(clamp (xlv_TEXCOORD6, 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v3, c11, c11.zwzw
dp4 oT4.x, c4, v0
dp4 oT4.y, c5, v0
dp4 oT4.z, c6, v0
dp4 r0.x, c2, v0
mul r0.y, r0.x, c10.y
mov oPos.z, r0.x
exp oT6.x, -r0.y
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, v2.y, c8.zxyw
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.y
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.z
mov oT3.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedpjhlhiaflhikdpgfbaocjdoopjififcjabaaaaaaoeahaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoiafaaaaeaaaabaa
hkabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
adaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaa
aaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedeehijkmkabieenpfplbjpejodaoljfddabaaaaaaeialaaaaaeaaaaaa
daaaaaaajaadaaaaiaajaaaahiakaaaaebgpgodjfiadaaaafiadaaaaaaacpopp
aaadaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaanaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahia
aaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaeaaahoaajaaoekaaaaappja
aaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaakkiaanaaffka
aoaaaaacaaaaaeoaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaafaaaaadaaaaahiaabaaffjaahaamjkaaeaaaaae
aaaaahiaagaamjkaabaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaamjkaabaakkja
aaaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadaaaaahiaaaaappiaaaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaad
abaaaciaacaaaajaakaaaakaafaaaaadabaaaeiaacaaaajaalaaaakaafaaaaad
abaaabiaacaaaajaamaaaakaafaaaaadacaaaciaacaaffjaakaaffkaafaaaaad
acaaaeiaacaaffjaalaaffkaafaaaaadacaaabiaacaaffjaamaaffkaacaaaaad
abaaahiaabaaoeiaacaaoeiaafaaaaadacaaaciaacaakkjaakaakkkaafaaaaad
acaaaeiaacaakkjaalaakkkaafaaaaadacaaabiaacaakkjaamaakkkaacaaaaad
abaaahiaabaaoeiaacaaoeiaaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaac
aaaaaiiaaaaappiaafaaaaadabaaahiaaaaappiaabaaoeiaafaaaaadacaaahia
aaaaoeiaabaaoeiaaeaaaaaeacaaahiaabaanciaaaaamjiaacaaoeibafaaaaad
acaaahiaacaaoeiaabaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoa
abaaffiaabaaaaacacaaaboaaaaaaaiaabaaaaacadaaaboaaaaaffiaabaaaaac
acaaacoaacaaffiaabaaaaacadaaacoaacaakkiaabaaaaacacaaaeoaabaakkia
abaaaaacadaaaeoaabaaaaiappppaaaafdeieefcoiafaaaaeaaaabaahkabaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
eccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaa
bkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
anaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaaacaaaaaa
bkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaajgiecaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaamaaaaaa
agbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaa
abaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaa
abaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaa
acaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaaaaaaaaaa
dgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaaadaaaaaa
akaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaf
cccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaa
acaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaagaaaaaa
aaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
  vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * TANGENT.w);
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_5.x;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_7.y;
  tmpvar_10.y = tmpvar_8.y;
  tmpvar_10.z = tmpvar_5.y;
  vec3 tmpvar_11;
  tmpvar_11.x = tmpvar_7.z;
  tmpvar_11.y = tmpvar_8.z;
  tmpvar_11.z = tmpvar_5.z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD6 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz * _Color.xyz);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD4;
  vec4 tmpvar_7;
  tmpvar_7 = (_LightMatrix0 * tmpvar_6);
  float tmpvar_8;
  tmpvar_8 = ((float(
    (tmpvar_7.z > 0.0)
  ) * texture2D (_LightTexture0, (
    (tmpvar_7.xy / tmpvar_7.w)
   + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_7.xyz, tmpvar_7.xyz))).w);
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4)));
  float tmpvar_12;
  tmpvar_12 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_11 + tmpvar_10)))
  ), (_Shininess * 128.0)) * tmpvar_3.w);
  c_9.xyz = (((
    ((tmpvar_4 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_11)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_12)
  ) * (tmpvar_8 * 2.0)) + ((tmpvar_4 * _LightColor0.xyz) * (
    (((tmpvar_8 * 2.0) * (pow (
      max (0.0, dot (tmpvar_10, -((tmpvar_11 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_9.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_12) * tmpvar_8);
  c_2.xyz = mix (vec3(0.0, 0.0, 0.0), c_9.xyz, vec3(clamp (xlv_TEXCOORD6, 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v3, c11, c11.zwzw
dp4 oT4.x, c4, v0
dp4 oT4.y, c5, v0
dp4 oT4.z, c6, v0
dp4 r0.x, c2, v0
mul r0.y, r0.x, c10.y
mov oPos.z, r0.x
exp oT6.x, -r0.y
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, v2.y, c8.zxyw
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.y
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.z
mov oT3.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedlbcpalnfemlbfhjcmggdalkcbapfjmpeabaaaaaaoeahaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoiafaaaaeaaaabaa
hkabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
adaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaa
aaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedkglfhcokocnkddobjoldacafedgkbhnbabaaaaaaeialaaaaaeaaaaaa
daaaaaaajaadaaaaiaajaaaahiakaaaaebgpgodjfiadaaaafiadaaaaaaacpopp
aaadaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaabbaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahia
aaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaeaaahoaajaaoekaaaaappja
aaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaakkiaanaaffka
aoaaaaacaaaaaeoaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaafaaaaadaaaaahiaabaaffjaahaamjkaaeaaaaae
aaaaahiaagaamjkaabaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaamjkaabaakkja
aaaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadaaaaahiaaaaappiaaaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaad
abaaaciaacaaaajaakaaaakaafaaaaadabaaaeiaacaaaajaalaaaakaafaaaaad
abaaabiaacaaaajaamaaaakaafaaaaadacaaaciaacaaffjaakaaffkaafaaaaad
acaaaeiaacaaffjaalaaffkaafaaaaadacaaabiaacaaffjaamaaffkaacaaaaad
abaaahiaabaaoeiaacaaoeiaafaaaaadacaaaciaacaakkjaakaakkkaafaaaaad
acaaaeiaacaakkjaalaakkkaafaaaaadacaaabiaacaakkjaamaakkkaacaaaaad
abaaahiaabaaoeiaacaaoeiaaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaac
aaaaaiiaaaaappiaafaaaaadabaaahiaaaaappiaabaaoeiaafaaaaadacaaahia
aaaaoeiaabaaoeiaaeaaaaaeacaaahiaabaanciaaaaamjiaacaaoeibafaaaaad
acaaahiaacaaoeiaabaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoa
abaaffiaabaaaaacacaaaboaaaaaaaiaabaaaaacadaaaboaaaaaffiaabaaaaac
acaaacoaacaaffiaabaaaaacadaaacoaacaakkiaabaaaaacacaaaeoaabaakkia
abaaaaacadaaaeoaabaaaaiappppaaaafdeieefcoiafaaaaeaaaabaahkabaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
eccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaa
bkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
bbaaaaaaogikcaaaaaaaaaaabbaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaaacaaaaaa
bkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaajgiecaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaamaaaaaa
agbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaa
abaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaa
abaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaa
acaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaaaaaaaaaa
dgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaaadaaaaaa
akaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaf
cccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaa
acaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaagaaaaaa
aaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
  vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * TANGENT.w);
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_5.x;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_7.y;
  tmpvar_10.y = tmpvar_8.y;
  tmpvar_10.z = tmpvar_5.y;
  vec3 tmpvar_11;
  tmpvar_11.x = tmpvar_7.z;
  tmpvar_11.y = tmpvar_8.z;
  tmpvar_11.z = tmpvar_5.z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD6 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz * _Color.xyz);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD4;
  vec3 tmpvar_7;
  tmpvar_7 = (_LightMatrix0 * tmpvar_6).xyz;
  float tmpvar_8;
  tmpvar_8 = (texture2D (_LightTextureB0, vec2(dot (tmpvar_7, tmpvar_7))).w * textureCube (_LightTexture0, tmpvar_7).w);
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4)));
  float tmpvar_12;
  tmpvar_12 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_11 + tmpvar_10)))
  ), (_Shininess * 128.0)) * tmpvar_3.w);
  c_9.xyz = (((
    ((tmpvar_4 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_11)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_12)
  ) * (tmpvar_8 * 2.0)) + ((tmpvar_4 * _LightColor0.xyz) * (
    (((tmpvar_8 * 2.0) * (pow (
      max (0.0, dot (tmpvar_10, -((tmpvar_11 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_9.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_12) * tmpvar_8);
  c_2.xyz = mix (vec3(0.0, 0.0, 0.0), c_9.xyz, vec3(clamp (xlv_TEXCOORD6, 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v3, c11, c11.zwzw
dp4 oT4.x, c4, v0
dp4 oT4.y, c5, v0
dp4 oT4.z, c6, v0
dp4 r0.x, c2, v0
mul r0.y, r0.x, c10.y
mov oPos.z, r0.x
exp oT6.x, -r0.y
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, v2.y, c8.zxyw
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.y
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.z
mov oT3.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedlbcpalnfemlbfhjcmggdalkcbapfjmpeabaaaaaaoeahaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoiafaaaaeaaaabaa
hkabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
adaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaa
aaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedkglfhcokocnkddobjoldacafedgkbhnbabaaaaaaeialaaaaaeaaaaaa
daaaaaaajaadaaaaiaajaaaahiakaaaaebgpgodjfiadaaaafiadaaaaaaacpopp
aaadaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaabbaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahia
aaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaeaaahoaajaaoekaaaaappja
aaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaakkiaanaaffka
aoaaaaacaaaaaeoaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaafaaaaadaaaaahiaabaaffjaahaamjkaaeaaaaae
aaaaahiaagaamjkaabaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaamjkaabaakkja
aaaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadaaaaahiaaaaappiaaaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaad
abaaaciaacaaaajaakaaaakaafaaaaadabaaaeiaacaaaajaalaaaakaafaaaaad
abaaabiaacaaaajaamaaaakaafaaaaadacaaaciaacaaffjaakaaffkaafaaaaad
acaaaeiaacaaffjaalaaffkaafaaaaadacaaabiaacaaffjaamaaffkaacaaaaad
abaaahiaabaaoeiaacaaoeiaafaaaaadacaaaciaacaakkjaakaakkkaafaaaaad
acaaaeiaacaakkjaalaakkkaafaaaaadacaaabiaacaakkjaamaakkkaacaaaaad
abaaahiaabaaoeiaacaaoeiaaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaac
aaaaaiiaaaaappiaafaaaaadabaaahiaaaaappiaabaaoeiaafaaaaadacaaahia
aaaaoeiaabaaoeiaaeaaaaaeacaaahiaabaanciaaaaamjiaacaaoeibafaaaaad
acaaahiaacaaoeiaabaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoa
abaaffiaabaaaaacacaaaboaaaaaaaiaabaaaaacadaaaboaaaaaffiaabaaaaac
acaaacoaacaaffiaabaaaaacadaaacoaacaakkiaabaaaaacacaaaeoaabaakkia
abaaaaacadaaaeoaabaaaaiappppaaaafdeieefcoiafaaaaeaaaabaahkabaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
eccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaa
bkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
bbaaaaaaogikcaaaaaaaaaaabbaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaaacaaaaaa
bkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaajgiecaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaamaaaaaa
agbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaa
abaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaa
abaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaa
acaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaaaaaaaaaa
dgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaaadaaaaaa
akaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaf
cccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaa
acaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaagaaaaaa
aaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
  vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * TANGENT.w);
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_5.x;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_7.y;
  tmpvar_10.y = tmpvar_8.y;
  tmpvar_10.z = tmpvar_5.y;
  vec3 tmpvar_11;
  tmpvar_11.x = tmpvar_7.z;
  tmpvar_11.y = tmpvar_8.z;
  tmpvar_11.z = tmpvar_5.z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD6 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Thickness;
uniform float _Scale;
uniform float _Power;
uniform float _Distortion;
uniform vec4 _Color;
uniform vec4 _SubColor;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz * _Color.xyz);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD4;
  float tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, (_LightMatrix0 * tmpvar_6).xy).w;
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_8;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  float tmpvar_11;
  tmpvar_11 = (pow (max (0.0, 
    dot (worldN_1, normalize((tmpvar_10 + tmpvar_9)))
  ), (_Shininess * 128.0)) * tmpvar_3.w);
  c_8.xyz = (((
    ((tmpvar_4 * _LightColor0.xyz) * max (0.0, dot (worldN_1, tmpvar_10)))
   + 
    ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_11)
  ) * (tmpvar_7 * 2.0)) + ((tmpvar_4 * _LightColor0.xyz) * (
    (((tmpvar_7 * 2.0) * (pow (
      max (0.0, dot (tmpvar_9, -((tmpvar_10 + 
        (worldN_1 * _Distortion)
      ))))
    , _Power) * _Scale)) * texture2D (_Thickness, xlv_TEXCOORD0).x)
   * _SubColor.xyz)));
  c_8.w = (((_LightColor0.w * _SpecColor.w) * tmpvar_11) * tmpvar_7);
  c_2.xyz = mix (vec3(0.0, 0.0, 0.0), c_8.xyz, vec3(clamp (xlv_TEXCOORD6, 0.0, 1.0)));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v3, c11, c11.zwzw
dp4 oT4.x, c4, v0
dp4 oT4.y, c5, v0
dp4 oT4.z, c6, v0
dp4 r0.x, c2, v0
mul r0.y, r0.x, c10.y
mov oPos.z, r0.x
exp oT6.x, -r0.y
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT1.x, r0.z
mul r1.xyz, v2.y, c8.zxyw
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov oT1.y, r2.x
mov oT1.z, r1.y
mov oT2.x, r0.x
mov oT3.x, r0.y
mov oT2.y, r2.y
mov oT3.y, r2.z
mov oT2.z, r1.z
mov oT3.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedlbcpalnfemlbfhjcmggdalkcbapfjmpeabaaaaaaoeahaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoiafaaaaeaaaabaa
hkabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
adaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaa
aaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedkglfhcokocnkddobjoldacafedgkbhnbabaaaaaaeialaaaaaeaaaaaa
daaaaaaajaadaaaaiaajaaaahiakaaaaebgpgodjfiadaaaafiadaaaaaaacpopp
aaadaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaabbaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahia
aaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaeaaahoaajaaoekaaaaappja
aaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaakkiaanaaffka
aoaaaaacaaaaaeoaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaafaaaaadaaaaahiaabaaffjaahaamjkaaeaaaaae
aaaaahiaagaamjkaabaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaamjkaabaakkja
aaaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadaaaaahiaaaaappiaaaaaoeiaabaaaaacabaaaboaaaaakkiaafaaaaad
abaaaciaacaaaajaakaaaakaafaaaaadabaaaeiaacaaaajaalaaaakaafaaaaad
abaaabiaacaaaajaamaaaakaafaaaaadacaaaciaacaaffjaakaaffkaafaaaaad
acaaaeiaacaaffjaalaaffkaafaaaaadacaaabiaacaaffjaamaaffkaacaaaaad
abaaahiaabaaoeiaacaaoeiaafaaaaadacaaaciaacaakkjaakaakkkaafaaaaad
acaaaeiaacaakkjaalaakkkaafaaaaadacaaabiaacaakkjaamaakkkaacaaaaad
abaaahiaabaaoeiaacaaoeiaaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaac
aaaaaiiaaaaappiaafaaaaadabaaahiaaaaappiaabaaoeiaafaaaaadacaaahia
aaaaoeiaabaaoeiaaeaaaaaeacaaahiaabaanciaaaaamjiaacaaoeibafaaaaad
acaaahiaacaaoeiaabaappjaabaaaaacabaaacoaacaaaaiaabaaaaacabaaaeoa
abaaffiaabaaaaacacaaaboaaaaaaaiaabaaaaacadaaaboaaaaaffiaabaaaaac
acaaacoaacaaffiaabaaaaacadaaacoaacaakkiaabaaaaacacaaaeoaabaakkia
abaaaaacadaaaeoaabaaaaiappppaaaafdeieefcoiafaaaaeaaaabaahkabaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
eccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaa
bkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
bbaaaaaaogikcaaaaaaaaaaabbaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaaacaaaaaa
bkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaajgiecaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaamaaaaaa
agbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaa
abaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaa
abaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaa
acaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaaaaaaaaaa
dgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaaadaaaaaa
akaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaf
cccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaa
acaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaagaaaaaa
aaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
}
Program "fp" {
// Platform d3d9 had shader errors
//   Keywords { "SPOT" "FOG_EXP" }
SubProgram "opengl " {
Keywords { "POINT" }
"!!GLSL"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Thickness] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedppobigfdhaiianpnfbnnoecchnhgpjpmabaaaaaalmaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjmahaaaa
eaaaaaaaohabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaa
adaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
acaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaa
akiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
aoaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
agaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaa
egacbaaaabaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadeaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
anaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaadcaaaaajocaabaaa
aaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaa
afaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaaiocaabaaaabaaaaaaagaabaaaaaaaaaaaagijcaaaaaaaaaaa
apaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
dcaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaabaaaaaajgahbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Thickness] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0_level_9_1
eefiecedelbodfeegakddefhalhbipmomlpdjhlnabaaaaaacaanaaaaaeaaaaaa
daaaaaaajaaeaaaadeamaaaaomamaaaaebgpgodjfiaeaaaafiaeaaaaaaacpppp
peadaaaageaaaaaaaeaadeaaaaaageaaaaaageaaaeaaceaaaaaageaaadaaaaaa
aaababaaacacacaaabadadaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaaaiaaacaa
aaaaaaaaabaaaeaaabaaakaaaaaaaaaaacaaaaaaabaaalaaaaaaaaaaaaacpppp
fbaaaaafamaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafanaaapka
aaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachla
bpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaafaaaaad
aaaachiaaeaafflaadaaoekaaeaaaaaeaaaachiaacaaoekaaeaaaalaaaaaoeia
aeaaaaaeaaaachiaaeaaoekaaeaakklaaaaaoeiaacaaaaadaaaachiaaaaaoeia
afaaoekaaiaaaaadaaaacdiaaaaaoeiaaaaaoeiaecaaaaadabaacpiaaaaaoela
acaioekaecaaaaadacaacpiaaaaaoelaabaioekaecaaaaadaaaacpiaaaaaoeia
aaaioekaecaaaaadadaacpiaaaaaoelaadaioekaacaaaaadaeaaahiaaeaaoelb
akaaoekaceaaaaacafaachiaaeaaoeiaacaaaaadaeaaahiaaeaaoelbalaaoeka
aiaaaaadaeaaaiiaaeaaoeiaaeaaoeiaahaaaaacaeaaaiiaaeaappiaaeaaaaae
agaachiaaeaaoeiaaeaappiaafaaoeiaafaaaaadaeaachiaaeaappiaaeaaoeia
ceaaaaacahaachiaagaaoeiaaeaaaaaeagaacbiaabaappiaamaaaakaamaaffka
aeaaaaaeagaacciaabaaffiaamaaaakaamaaffkafkaaaaaeaeaadiiaagaaoeia
agaaoeiaamaakkkaacaaaaadaeaaciiaaeaappibamaappkaahaaaaacaeaaciia
aeaappiaagaaaaacagaaceiaaeaappiaaiaaaaadabaacbiaabaaoelaagaaoeia
aiaaaaadabaacciaacaaoelaagaaoeiaaiaaaaadabaaceiaadaaoelaagaaoeia
aiaaaaadabaaciiaabaaoeiaahaaoeiaalaaaaadaeaaaiiaabaappiaamaakkka
abaaaaacabaaaiiaajaaaakaafaaaaadabaaaiiaabaappiaanaaaakacaaaaaad
afaaaiiaaeaappiaabaappiaafaaaaadabaaaiiaacaappiaafaappiaafaaaaad
aaaacoiaacaabliaahaablkaafaaaaadaaaacoiaaaaaoeiaaaaablkaabaaaaac
acaaahiaaaaaoekaafaaaaadacaaahiaacaaoeiaabaaoekaafaaaaadacaaahia
abaappiaacaaoeiaaiaaaaadabaaciiaabaaoeiaaeaaoeiaaeaaaaaeabaachia
abaaoeiaagaakkkaaeaaoeiaaiaaaaadacaaciiaafaaoeiaabaaoeibalaaaaad
abaaabiaacaappiaamaakkkacaaaaaadacaaaiiaabaaaaiaagaaffkaafaaaaad
acaaaiiaacaappiaagaaaakaalaaaaadadaacciaabaappiaamaakkkaaeaaaaae
abaaahiaaaaabliaadaaffiaacaaoeiaacaaaaadabaaaiiaaaaaaaiaaaaaaaia
afaaaaadaaaaabiaacaappiaabaappiaafaaaaadaaaaabiaadaaaaiaaaaaaaia
afaaaaadacaachiaaaaaaaiaaiaaoekaafaaaaadaaaachiaaaaabliaacaaoeia
aeaaaaaeaaaachiaabaaoeiaabaappiaaaaaoeiaabaaaaacaaaaciiaamaappka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcjmahaaaaeaaaaaaaohabaaaa
fjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaia
ebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaacaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
adaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaa
egacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaaakiacaaaaaaaaaaa
baaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaaoaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaaj
hcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaabaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
deaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaanaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaa
acaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
amaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
aaaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaai
ocaabaaaabaaaaaaagaabaaaaaaaaaaaagijcaaaaaaaaaaaapaaaaaadiaaaaah
ocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaadcaaaaajhccabaaa
aaaaaaaajgahbaaaaaaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
"!!GLSL"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Thickness] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedgbkjdhpdpgcgnkohhiijjmejjmgookklabaaaaaaieahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgeagaaaa
eaaaaaaajjabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaa
baaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaah
ecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaa
aaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaajhcaabaaaadaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaa
aeaaaaaakgikcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaapaaaaaibcaabaaaaaaaaaaaagaabaaaaaaaaaaaagiacaaa
aaaaaaaaajaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaa
aaaaaaaaagajbaaaadaaaaaaaaaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
fgaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaalaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Thickness] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0_level_9_1
eefiecedojfimidlcnejgomfbeoglhjopnnmgkooabaaaaaafaalaaaaaeaaaaaa
daaaaaaapiadaaaageakaaaabmalaaaaebgpgodjmaadaaaamaadaaaaaaacpppp
gaadaaaagaaaaaaaaeaadaaaaaaagaaaaaaagaaaadaaceaaaaaagaaaaaaaaaaa
acababaaabacacaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaaaeaaacaaaaaaaaaa
abaaaeaaabaaagaaaaaaaaaaacaaaaaaabaaahaaaaaaaaaaaaacppppfbaaaaaf
aiaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafajaaapkaaaaaaaed
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaia
abaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaac
aaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaaaaaoelaabaioekaecaaaaad
abaacpiaaaaaoelaaaaioekaecaaaaadacaacpiaaaaaoelaacaioekaacaaaaad
adaaahiaaeaaoelbagaaoekaceaaaaacaeaachiaadaaoeiaaiaaaaadaeaaciia
ahaaoekaahaaoekaahaaaaacaeaaciiaaeaappiaaeaaaaaeadaachiaahaaoeka
aeaappiaaeaaoeiaafaaaaadafaachiaaeaappiaahaaoekaceaaaaacagaachia
adaaoeiaaeaaaaaeadaacbiaaaaappiaaiaaaakaaiaaffkaaeaaaaaeadaaccia
aaaaffiaaiaaaakaaiaaffkafkaaaaaeadaadiiaadaaoeiaadaaoeiaaiaakkka
acaaaaadadaaciiaadaappibaiaappkaahaaaaacadaaciiaadaappiaagaaaaac
adaaceiaadaappiaaiaaaaadaaaacbiaabaaoelaadaaoeiaaiaaaaadaaaaccia
acaaoelaadaaoeiaaiaaaaadaaaaceiaadaaoelaadaaoeiaaiaaaaadaaaaciia
aaaaoeiaagaaoeiaalaaaaadaeaaaiiaaaaappiaaiaakkkaabaaaaacaaaaaiia
afaaaakaafaaaaadaaaaaiiaaaaappiaajaaaakacaaaaaadafaaaiiaaeaappia
aaaappiaafaaaaadaaaaaiiaabaappiaafaappiaafaaaaadabaachiaabaaoeia
adaaoekaafaaaaadabaachiaabaaoeiaaaaaoekaabaaaaacadaaahiaaaaaoeka
afaaaaadacaaaoiaadaabliaabaablkaafaaaaadacaaaoiaaaaappiaacaaoeia
aiaaaaadaaaaciiaaaaaoeiaafaaoeiaaeaaaaaeaaaachiaaaaaoeiaacaakkka
afaaoeiaaiaaaaadabaaciiaaeaaoeiaaaaaoeibalaaaaadaaaaabiaabaappia
aiaakkkacaaaaaadabaaaiiaaaaaaaiaacaaffkaafaaaaadabaaaiiaabaappia
acaaaakaacaaaaadabaaaiiaabaappiaabaappiaalaaaaadadaacbiaaaaappia
aiaakkkaaeaaaaaeaaaaahiaabaaoeiaadaaaaiaacaabliaacaaaaadaaaachia
aaaaoeiaaaaaoeiaafaaaaadaaaaaiiaacaaaaiaabaappiaafaaaaadacaachia
aaaappiaaeaaoekaaeaaaaaeaaaachiaabaaoeiaacaaoeiaaaaaoeiaabaaaaac
aaaaciiaaiaappkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcgeagaaaa
eaaaaaaajjabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaa
baaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaah
ecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaa
aaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaajhcaabaaaadaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaa
aeaaaaaakgikcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaapaaaaaibcaabaaaaaaaaaaaagaabaaaaaaaaaaaagiacaaa
aaaaaaaaajaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaa
aaaaaaaaagajbaaaadaaaaaaaaaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
fgaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaalaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" }
"!!GLSL"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Thickness] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedekcalpjpmaknkomapgpagkcdpconaahiabaaaaaakeajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcieaiaaaa
eaaaaaaacbacaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaafaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaaegaobaaa
aaaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
amaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaa
aaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaagaabaaaaaaaaaaaeghobaaaaeaaaaaa
aagabaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaacaaaaaaaaaaaaaj
ocaabaaaaaaaaaaaagbjbaiaebaaaaaaafaaaaaaagijcaaaabaaaaaaaeaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagaabaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaa
afaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaajgahbaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
abaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaa
adaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaadaaaaaa
egaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaa
egbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaa
aeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaabjaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
dkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
aaaaaaaaaoaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
aaaaaaaaagaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaa
egiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaa
anaaaaaaegacbaaaabaaaaaabaaaaaaiccaabaaaaaaaaaaajgahbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaabjaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaanaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadeaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgakbaaa
aaaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaadaaaaaadiaaaaaiocaabaaaaaaaaaaafgafbaaaaaaaaaaa
agijcaaaaaaaaaaaapaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agajbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Thickness] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0_level_9_1
eefiecedimglebccmmdlknolkafigljhdmnjlemaabaaaaaagmaoaaaaaeaaaaaa
daaaaaaapeaeaaaaiaanaaaadiaoaaaaebgpgodjlmaeaaaalmaeaaaaaaacpppp
feaeaaaagiaaaaaaaeaadiaaaaaagiaaaaaagiaaafaaceaaaaaagiaaadaaaaaa
aeababaaaaacacaaacadadaaabaeaeaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaa
aiaaacaaaaaaaaaaabaaaeaaabaaakaaaaaaaaaaacaaaaaaabaaalaaaaaaaaaa
aaacppppfbaaaaafamaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
anaaapkaaaaaaadpaaaaaaedaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaia
adaachlabpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
bpaaaaacaaaaaajaaeaiapkaafaaaaadaaaacpiaaeaafflaadaaoekaaeaaaaae
aaaacpiaacaaoekaaeaaaalaaaaaoeiaaeaaaaaeaaaacpiaaeaaoekaaeaakkla
aaaaoeiaacaaaaadaaaacpiaaaaaoeiaafaaoekaagaaaaacaaaaaiiaaaaappia
aeaaaaaeabaacdiaaaaaoeiaaaaappiaanaaaakaaiaaaaadaaaacdiaaaaaoeia
aaaaoeiaecaaaaadabaacpiaabaaoeiaaaaioekaecaaaaadacaacpiaaaaaoeia
abaioekaecaaaaadadaacpiaaaaaoelaadaioekaecaaaaadaeaacpiaaaaaoela
acaioekaecaaaaadafaacpiaaaaaoelaaeaioekaafaaaaadaaaacbiaabaappia
acaaaaiafiaaaaaeaaaacbiaaaaakkibamaakkkaaaaaaaiaacaaaaadaaaaabia
aaaaaaiaaaaaaaiaacaaaaadabaaahiaaeaaoelbakaaoekaceaaaaacacaachia
abaaoeiaacaaaaadabaaahiaaeaaoelbalaaoekaaiaaaaadabaaaiiaabaaoeia
abaaoeiaahaaaaacabaaaiiaabaappiaaeaaaaaeagaachiaabaaoeiaabaappia
acaaoeiaafaaaaadabaachiaabaappiaabaaoeiaceaaaaacahaachiaagaaoeia
aeaaaaaeagaacbiaadaappiaamaaaakaamaaffkaaeaaaaaeagaacciaadaaffia
amaaaakaamaaffkafkaaaaaeabaadiiaagaaoeiaagaaoeiaamaakkkaacaaaaad
abaaciiaabaappibamaappkaahaaaaacabaaciiaabaappiaagaaaaacagaaceia
abaappiaaiaaaaadadaacbiaabaaoelaagaaoeiaaiaaaaadadaacciaacaaoela
agaaoeiaaiaaaaadadaaceiaadaaoelaagaaoeiaaiaaaaadabaaciiaadaaoeia
ahaaoeiaalaaaaadacaaaiiaabaappiaamaakkkaabaaaaacabaaaiiaanaaffka
afaaaaadabaaaiiaabaappiaajaaaakacaaaaaadadaaaiiaacaappiaabaappia
afaaaaadabaaaiiaaeaappiaadaappiaafaaaaadaaaacoiaaeaabliaahaablka
afaaaaadaaaacoiaaaaaoeiaaaaablkaabaaaaacaeaaahiaaaaaoekaafaaaaad
aeaaahiaaeaaoeiaabaaoekaafaaaaadaeaaahiaabaappiaaeaaoeiaaiaaaaad
abaaciiaadaaoeiaabaaoeiaaeaaaaaeabaachiaadaaoeiaagaakkkaabaaoeia
aiaaaaadaeaaciiaacaaoeiaabaaoeibalaaaaadabaaabiaaeaappiaamaakkka
caaaaaadaeaaaiiaabaaaaiaagaaffkaafaaaaadaeaaaiiaaeaappiaagaaaaka
afaaaaadaeaaaiiaaaaaaaiaaeaappiaalaaaaadacaacbiaabaappiaamaakkka
aeaaaaaeabaaahiaaaaabliaacaaaaiaaeaaoeiaafaaaaadabaaaiiaafaaaaia
aeaappiaafaaaaadacaachiaabaappiaaiaaoekaafaaaaadaaaacoiaaaaaoeia
acaabliaaeaaaaaeaaaachiaabaaoeiaaaaaaaiaaaaabliaabaaaaacaaaaciia
amaappkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcieaiaaaaeaaaaaaa
cbacaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
afaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaajaaaaaaagbabaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaaegaobaaaaaaaaaaa
aaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaamaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaaaaaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaagaabaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaa
abaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaaapaaaaah
bcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaacaaaaaaaaaaaaajocaabaaa
aaaaaaaaagbjbaiaebaaaaaaafaaaaaaagijcaaaabaaaaaaaeaaaaaabaaaaaah
bcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agaabaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaajgahbaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaa
adaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaa
acaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaibcaabaaaacaaaaaa
akiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaabjaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
aoaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
agaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaa
egacbaaaabaaaaaabaaaaaaiccaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaabjaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaanaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadeaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgakbaaaaaaaaaaa
egacbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaadaaaaaadiaaaaaiocaabaaaaaaaaaaafgafbaaaaaaaaaaaagijcaaa
aaaaaaaaapaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
acaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
ejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
"!!GLSL"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Thickness] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecednhfcdnkpjfdkfeliigphoblhmnaecpkfabaaaaaapmaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmahaaaa
eaaaaaaaphabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaa
ddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaaakiacaaa
aaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaaoaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaagaaaaaa
diaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaa
ahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaa
abaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadeaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaadcaaaaajocaabaaaaaaaaaaa
agajbaaaacaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaamaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegacbaaaabaaaaaaeghobaaaaeaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaaapaaaaahbcaabaaaabaaaaaaagaabaaaabaaaaaa
pgapbaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaaiocaabaaaabaaaaaaagaabaaaaaaaaaaaagijcaaaaaaaaaaa
apaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
dcaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaabaaaaaajgahbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Thickness] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0_level_9_1
eefiecedbbhdgfjaohhoebnckbgilekppmgkmkpgabaaaaaajmanaaaaaeaaaaaa
daaaaaaammaeaaaalaamaaaagianaaaaebgpgodjjeaeaaaajeaeaaaaaaacpppp
cmaeaaaagiaaaaaaaeaadiaaaaaagiaaaaaagiaaafaaceaaaaaagiaaaeaaaaaa
adababaaaaacacaaacadadaaabaeaeaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaa
aiaaacaaaaaaaaaaabaaaeaaabaaakaaaaaaaaaaacaaaaaaabaaalaaaaaaaaaa
aaacppppfbaaaaafamaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
anaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaia
adaachlabpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajiaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
bpaaaaacaaaaaajaaeaiapkaafaaaaadaaaachiaaeaafflaadaaoekaaeaaaaae
aaaachiaacaaoekaaeaaaalaaaaaoeiaaeaaaaaeaaaachiaaeaaoekaaeaakkla
aaaaoeiaacaaaaadaaaachiaaaaaoeiaafaaoekaaiaaaaadaaaaciiaaaaaoeia
aaaaoeiaabaaaaacabaacdiaaaaappiaecaaaaadaaaaapiaaaaaoeiaaaaioeka
ecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadacaacpiaaaaaoelaadaioeka
ecaaaaadadaacpiaaaaaoelaacaioekaecaaaaadaeaacpiaaaaaoelaaeaioeka
afaaaaadaaaacbiaaaaappiaabaaaaiaacaaaaadaaaaabiaaaaaaaiaaaaaaaia
acaaaaadabaaahiaaeaaoelbakaaoekaceaaaaacafaachiaabaaoeiaacaaaaad
abaaahiaaeaaoelbalaaoekaaiaaaaadabaaaiiaabaaoeiaabaaoeiaahaaaaac
abaaaiiaabaappiaaeaaaaaeagaachiaabaaoeiaabaappiaafaaoeiaafaaaaad
abaachiaabaappiaabaaoeiaceaaaaacahaachiaagaaoeiaaeaaaaaeagaacbia
acaappiaamaaaakaamaaffkaaeaaaaaeagaacciaacaaffiaamaaaakaamaaffka
fkaaaaaeabaadiiaagaaoeiaagaaoeiaamaakkkaacaaaaadabaaciiaabaappib
amaappkaahaaaaacabaaciiaabaappiaagaaaaacagaaceiaabaappiaaiaaaaad
acaacbiaabaaoelaagaaoeiaaiaaaaadacaacciaacaaoelaagaaoeiaaiaaaaad
acaaceiaadaaoelaagaaoeiaaiaaaaadabaaciiaacaaoeiaahaaoeiaalaaaaad
acaaaiiaabaappiaamaakkkaabaaaaacabaaaiiaajaaaakaafaaaaadabaaaiia
abaappiaanaaaakacaaaaaadafaaaiiaacaappiaabaappiaafaaaaadabaaaiia
adaappiaafaappiaafaaaaadaaaacoiaadaabliaahaablkaafaaaaadaaaacoia
aaaaoeiaaaaablkaabaaaaacadaaahiaaaaaoekaafaaaaadadaaahiaadaaoeia
abaaoekaafaaaaadadaaahiaabaappiaadaaoeiaaiaaaaadabaaciiaacaaoeia
abaaoeiaaeaaaaaeabaachiaacaaoeiaagaakkkaabaaoeiaaiaaaaadadaaciia
afaaoeiaabaaoeibalaaaaadabaaabiaadaappiaamaakkkacaaaaaadadaaaiia
abaaaaiaagaaffkaafaaaaadadaaaiiaadaappiaagaaaakaafaaaaadadaaaiia
aaaaaaiaadaappiaalaaaaadacaacbiaabaappiaamaakkkaaeaaaaaeabaaahia
aaaabliaacaaaaiaadaaoeiaafaaaaadabaaaiiaaeaaaaiaadaappiaafaaaaad
acaachiaabaappiaaiaaoekaafaaaaadaaaacoiaaaaaoeiaacaabliaaeaaaaae
aaaachiaabaaoeiaaaaaaaiaaaaabliaabaaaaacaaaaciiaamaappkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcnmahaaaaeaaaaaaaphabaaaafjaaaaae
egiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaad
aagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacafaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaap
dcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaa
baaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaah
ecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaabaaaaaaakiacaaaaaaaaaaabaaaaaaaabeaaaaa
aaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaaaaaaaaaaoaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaajhcaabaaaadaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaa
aeaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaabaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaakdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaanaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaa
aaaaaaaaagajbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaafaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagbabaaaafaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegacbaaaabaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaapgapbaaaabaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaa
apaaaaahbcaabaaaabaaaaaaagaabaaaabaaaaaapgapbaaaadaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaaiocaabaaa
abaaaaaaagaabaaaaaaaaaaaagijcaaaaaaaaaaaapaaaaaadiaaaaahocaabaaa
abaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
jgahbaaaaaaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLSL"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Thickness] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedmoonknmbkblmoinenhenjgnplnkkcnflabaaaaaaimaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgmahaaaa
eaaaaaaanlabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
ccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
aeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaed
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaaoaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaa
aaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaa
kgikcaaaaaaaaaaaanaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaa
mgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaanaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
anaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaa
agajbaaaadaaaaaadiaaaaaidcaabaaaacaaaaaafgbfbaaaafaaaaaaegiacaaa
aaaaaaaaakaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaaaaaaaaaajaaaaaa
agbabaaaafaaaaaaegaabaaaacaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaa
aaaaaaaaalaaaaaakgbkbaaaafaaaaaaegaabaaaacaaaaaaaaaaaaaidcaabaaa
acaaaaaaegaabaaaacaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaah
icaabaaaabaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaa
aaaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Thickness] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0_level_9_1
eefiecedeadcofhblhdcnndkflhfippbopbkkdknabaaaaaanaamaaaaaeaaaaaa
daaaaaaahaaeaaaaoealaaaajmamaaaaebgpgodjdiaeaaaadiaeaaaaaaacpppp
neadaaaageaaaaaaaeaadeaaaaaageaaaaaageaaaeaaceaaaaaageaaadaaaaaa
aaababaaacacacaaabadadaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaaaiaaacaa
aaaaaaaaabaaaeaaabaaakaaaaaaaaaaacaaaaaaabaaalaaaaaaaaaaaaacpppp
fbaaaaafamaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafanaaapka
aaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachla
bpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaafaaaaad
aaaacdiaaeaafflaadaaoekaaeaaaaaeaaaacdiaacaaoekaaeaaaalaaaaaoeia
aeaaaaaeaaaacdiaaeaaoekaaeaakklaaaaaoeiaacaaaaadaaaacdiaaaaaoeia
afaaoekaecaaaaadabaacpiaaaaaoelaacaioekaecaaaaadacaacpiaaaaaoela
abaioekaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadadaacpiaaaaaoela
adaioekaacaaaaadaaaaahiaaeaaoelbakaaoekaceaaaaacaeaachiaaaaaoeia
aiaaaaadaeaaciiaalaaoekaalaaoekaahaaaaacaeaaciiaaeaappiaaeaaaaae
aaaachiaalaaoekaaeaappiaaeaaoeiaafaaaaadafaachiaaeaappiaalaaoeka
ceaaaaacagaachiaaaaaoeiaaeaaaaaeaaaacbiaabaappiaamaaaakaamaaffka
aeaaaaaeaaaacciaabaaffiaamaaaakaamaaffkafkaaaaaeaeaadiiaaaaaoeia
aaaaoeiaamaakkkaacaaaaadaeaaciiaaeaappibamaappkaahaaaaacaeaaciia
aeaappiaagaaaaacaaaaceiaaeaappiaaiaaaaadabaacbiaabaaoelaaaaaoeia
aiaaaaadabaacciaacaaoelaaaaaoeiaaiaaaaadabaaceiaadaaoelaaaaaoeia
aiaaaaadabaaciiaabaaoeiaagaaoeiaalaaaaadaeaaaiiaabaappiaamaakkka
abaaaaacabaaaiiaajaaaakaafaaaaadabaaaiiaabaappiaanaaaakacaaaaaad
afaaaiiaaeaappiaabaappiaafaaaaadabaaaiiaacaappiaafaappiaafaaaaad
aaaachiaacaaoeiaahaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoekaabaaaaac
acaaahiaaaaaoekaafaaaaadacaaahiaacaaoeiaabaaoekaafaaaaadacaaahia
abaappiaacaaoeiaaiaaaaadabaaciiaabaaoeiaafaaoeiaaeaaaaaeabaachia
abaaoeiaagaakkkaafaaoeiaaiaaaaadacaaciiaaeaaoeiaabaaoeibalaaaaad
abaaabiaacaappiaamaakkkacaaaaaadacaaaiiaabaaaaiaagaaffkaafaaaaad
acaaaiiaacaappiaagaaaakaalaaaaadadaacciaabaappiaamaakkkaaeaaaaae
abaaahiaaaaaoeiaadaaffiaacaaoeiaacaaaaadaaaaaiiaaaaappiaaaaappia
afaaaaadabaaaiiaacaappiaaaaappiaafaaaaadabaaaiiaadaaaaiaabaappia
afaaaaadacaachiaabaappiaaiaaoekaafaaaaadaaaachiaaaaaoeiaacaaoeia
aeaaaaaeaaaachiaabaaoeiaaaaappiaaaaaoeiaabaaaaacaaaaciiaamaappka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcgmahaaaaeaaaaaaanlabaaaa
fjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaia
ebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaa
adaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaa
egaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaa
egbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaa
aeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaa
egacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaaoaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaagaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaa
egiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaa
anaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaa
aaaaaaaaanaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaadcaaaaaj
ocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaa
diaaaaaidcaabaaaacaaaaaafgbfbaaaafaaaaaaegiacaaaaaaaaaaaakaaaaaa
dcaaaaakdcaabaaaacaaaaaaegiacaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaa
egaabaaaacaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaa
kgbkbaaaafaaaaaaegaabaaaacaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaaa
acaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaabaaaaaa
dkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d11 " {
Keywords { "POINT" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Thickness] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedbppjhjiadeodfighldlnmipkfgcfbhmoabaaaaaabaajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcniahaaaaeaaaaaaapgabaaaa
fjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaa
afaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaa
adaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaa
egaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaa
egbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaa
aeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
abaaaaaaakiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
aaaaaaaaaoaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
aaaaaaaaagaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaa
egiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaa
anaaaaaaegacbaaaabaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadeaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaa
aaaaaaaaanaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaadcaaaaaj
ocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaa
kgbkbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaadaaaaaadiaaaaaiocaabaaaabaaaaaaagaabaaaaaaaaaaaagijcaaa
aaaaaaaaapaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaabaaaaaa
jgahbaaaabaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Thickness] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0_level_9_1
eefiecedgbddhkfggphlfhjdfionccihjkaendfbabaaaaaajaanaaaaaeaaaaaa
daaaaaaakmaeaaaaimamaaaafmanaaaaebgpgodjheaeaaaaheaeaaaaaaacpppp
baaeaaaageaaaaaaaeaadeaaaaaageaaaaaageaaaeaaceaaaaaageaaadaaaaaa
aaababaaacacacaaabadadaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaaaiaaacaa
aaaaaaaaabaaaeaaabaaakaaaaaaaaaaacaaaaaaabaaalaaaaaaaaaaaaacpppp
fbaaaaafamaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafanaaapka
aaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachla
bpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaafaaaaad
aaaachiaaeaafflaadaaoekaaeaaaaaeaaaachiaacaaoekaaeaaaalaaaaaoeia
aeaaaaaeaaaachiaaeaaoekaaeaakklaaaaaoeiaacaaaaadaaaachiaaaaaoeia
afaaoekaaiaaaaadaaaacdiaaaaaoeiaaaaaoeiaecaaaaadabaacpiaaaaaoela
acaioekaecaaaaadacaacpiaaaaaoelaabaioekaecaaaaadaaaacpiaaaaaoeia
aaaioekaecaaaaadadaacpiaaaaaoelaadaioekaacaaaaadaeaaahiaaeaaoelb
akaaoekaceaaaaacafaachiaaeaaoeiaacaaaaadaeaaahiaaeaaoelbalaaoeka
aiaaaaadaeaaaiiaaeaaoeiaaeaaoeiaahaaaaacaeaaaiiaaeaappiaaeaaaaae
agaachiaaeaaoeiaaeaappiaafaaoeiaafaaaaadaeaachiaaeaappiaaeaaoeia
ceaaaaacahaachiaagaaoeiaaeaaaaaeagaacbiaabaappiaamaaaakaamaaffka
aeaaaaaeagaacciaabaaffiaamaaaakaamaaffkafkaaaaaeaeaadiiaagaaoeia
agaaoeiaamaakkkaacaaaaadaeaaciiaaeaappibamaappkaahaaaaacaeaaciia
aeaappiaagaaaaacagaaceiaaeaappiaaiaaaaadabaacbiaabaaoelaagaaoeia
aiaaaaadabaacciaacaaoelaagaaoeiaaiaaaaadabaaceiaadaaoelaagaaoeia
aiaaaaadabaaciiaabaaoeiaahaaoeiaalaaaaadaeaaaiiaabaappiaamaakkka
abaaaaacabaaaiiaajaaaakaafaaaaadabaaaiiaabaappiaanaaaakacaaaaaad
afaaaiiaaeaappiaabaappiaafaaaaadabaaaiiaacaappiaafaappiaafaaaaad
aaaacoiaacaabliaahaablkaafaaaaadaaaacoiaaaaaoeiaaaaablkaabaaaaac
acaaahiaaaaaoekaafaaaaadacaaahiaacaaoeiaabaaoekaafaaaaadacaaahia
abaappiaacaaoeiaaiaaaaadabaaciiaabaaoeiaaeaaoeiaaeaaaaaeabaachia
abaaoeiaagaakkkaaeaaoeiaaiaaaaadacaaciiaafaaoeiaabaaoeibalaaaaad
abaaabiaacaappiaamaakkkacaaaaaadacaaaiiaabaaaaiaagaaffkaafaaaaad
acaaaiiaacaappiaagaaaakaalaaaaadadaacciaabaappiaamaakkkaaeaaaaae
abaaahiaaaaabliaadaaffiaacaaoeiaacaaaaadabaaaiiaaaaaaaiaaaaaaaia
afaaaaadaaaaabiaacaappiaabaappiaafaaaaadaaaaabiaadaaaaiaaaaaaaia
afaaaaadacaachiaaaaaaaiaaiaaoekaafaaaaadaaaachiaaaaabliaacaaoeia
aeaaaaaeaaaachiaabaaoeiaabaappiaaaaaoeiaabaaaaacaaaabiiaaaaakkla
afaaaaadaaaachiaaaaaoeiaaaaappiaabaaaaacaaaaciiaamaappkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcniahaaaaeaaaaaaapgabaaaafjaaaaae
egiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaa
adaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
acaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaa
akiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
aoaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
agaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaa
egacbaaaabaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadeaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
anaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaadcaaaaajocaabaaa
aaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaa
afaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaaiocaabaaaabaaaaaaagaabaaaaaaaaaaaagijcaaaaaaaaaaa
apaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
dcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaabaaaaaajgahbaaa
abaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Thickness] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedhlhcjdmdoldcddminfaimeceaffalandabaaaaaaniahaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckaagaaaaeaaaaaaakiabaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaa
baaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaa
abeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaajhcaabaaa
adaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
egacbaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaabaaaaaai
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaak
dcaabaaaaaaaaaaamgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaapaaaaaibcaabaaaaaaaaaaaagaabaaaaaaaaaaa
agiacaaaaaaaaaaaajaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaa
fgafbaaaaaaaaaaaagajbaaaadaaaaaaaaaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaalaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaajgahbaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Thickness] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 144 [_Scale]
Float 148 [_Power]
Float 152 [_Distortion]
Vector 160 [_Color]
Vector 176 [_SubColor]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0_level_9_1
eefiecedoaofgojhcgckjdokpmmdgopjbacebphfabaaaaaamaalaaaaaeaaaaaa
daaaaaaabeaeaaaalmakaaaaimalaaaaebgpgodjnmadaaaanmadaaaaaaacpppp
hmadaaaagaaaaaaaaeaadaaaaaaagaaaaaaagaaaadaaceaaaaaagaaaaaaaaaaa
acababaaabacacaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaaaeaaacaaaaaaaaaa
abaaaeaaabaaagaaaaaaaaaaacaaaaaaabaaahaaaaaaaaaaaaacppppfbaaaaaf
aiaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafajaaapkaaaaaaaed
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaia
abaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaac
aaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaaaaaoelaabaioekaecaaaaad
abaacpiaaaaaoelaaaaioekaecaaaaadacaacpiaaaaaoelaacaioekaacaaaaad
adaaahiaaeaaoelbagaaoekaceaaaaacaeaachiaadaaoeiaaiaaaaadaeaaciia
ahaaoekaahaaoekaahaaaaacaeaaciiaaeaappiaaeaaaaaeadaachiaahaaoeka
aeaappiaaeaaoeiaafaaaaadafaachiaaeaappiaahaaoekaceaaaaacagaachia
adaaoeiaaeaaaaaeadaacbiaaaaappiaaiaaaakaaiaaffkaaeaaaaaeadaaccia
aaaaffiaaiaaaakaaiaaffkafkaaaaaeadaadiiaadaaoeiaadaaoeiaaiaakkka
acaaaaadadaaciiaadaappibaiaappkaahaaaaacadaaciiaadaappiaagaaaaac
adaaceiaadaappiaaiaaaaadaaaacbiaabaaoelaadaaoeiaaiaaaaadaaaaccia
acaaoelaadaaoeiaaiaaaaadaaaaceiaadaaoelaadaaoeiaaiaaaaadaaaaciia
aaaaoeiaagaaoeiaalaaaaadaeaaaiiaaaaappiaaiaakkkaabaaaaacaaaaaiia
afaaaakaafaaaaadaaaaaiiaaaaappiaajaaaakacaaaaaadafaaaiiaaeaappia
aaaappiaafaaaaadaaaaaiiaabaappiaafaappiaafaaaaadabaachiaabaaoeia
adaaoekaafaaaaadabaachiaabaaoeiaaaaaoekaabaaaaacadaaahiaaaaaoeka
afaaaaadacaaaoiaadaabliaabaablkaafaaaaadacaaaoiaaaaappiaacaaoeia
aiaaaaadaaaaciiaaaaaoeiaafaaoeiaaeaaaaaeaaaachiaaaaaoeiaacaakkka
afaaoeiaaiaaaaadabaaciiaaeaaoeiaaaaaoeibalaaaaadaaaaabiaabaappia
aiaakkkacaaaaaadabaaaiiaaaaaaaiaacaaffkaafaaaaadabaaaiiaabaappia
acaaaakaacaaaaadabaaaiiaabaappiaabaappiaalaaaaadadaacbiaaaaappia
aiaakkkaaeaaaaaeaaaaahiaabaaoeiaadaaaaiaacaabliaacaaaaadaaaachia
aaaaoeiaaaaaoeiaafaaaaadaaaaaiiaacaaaaiaabaappiaafaaaaadacaachia
aaaappiaaeaaoekaaeaaaaaeaaaachiaabaaoeiaacaaoeiaaaaaoeiaabaaaaac
aaaabiiaaaaakklaafaaaaadaaaachiaaaaaoeiaaaaappiaabaaaaacaaaaciia
aiaappkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefckaagaaaaeaaaaaaa
kiabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
afaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
abaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
adaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaa
egacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaa
amaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaaj
hcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
deaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaapaaaaaibcaabaaaaaaaaaaaagaabaaa
aaaaaaaaagiacaaaaaaaaaaaajaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaa
abaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaaaaaaaaahocaabaaaaaaaaaaa
fgaobaaaaaaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaalaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaajgahbaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaa
ckbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaalmaaaaaa
agaaaaaaaaaaaaaaadaaaaaaabaaaaaaaeaeaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "SPOT" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Thickness] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedbhmcmhadoccekigcnfpjmenimkblfkihabaaaaaapiajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaaiaaaaeaaaaaaadaacaaaa
fjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaafaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaa
egaobaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaamaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaa
aaaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaagaabaaaaaaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaa
aaaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaacaaaaaa
aaaaaaajocaabaaaaaaaaaaaagbjbaiaebaaaaaaafaaaaaaagijcaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaagaabaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaia
ebaaaaaaafaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
jgahbaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaah
bcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaa
aeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaa
egbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaai
bcaabaaaacaaaaaaakiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaabjaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaaoaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaagaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaa
agaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaaeaaaaaakgikcaaa
aaaaaaaaanaaaaaaegacbaaaabaaaaaabaaaaaaiccaabaaaaaaaaaaajgahbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaa
bjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahecaabaaaaaaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgakbaaaaaaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaaiocaabaaaaaaaaaaafgafbaaa
aaaaaaaaagijcaaaaaaaaaaaapaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Thickness] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0_level_9_1
eefiecedanedaifeebdagajeobbbieajnegmlnkmabaaaaaanmaoaaaaaeaaaaaa
daaaaaaabaafaaaanianaaaakiaoaaaaebgpgodjniaeaaaaniaeaaaaaaacpppp
haaeaaaagiaaaaaaaeaadiaaaaaagiaaaaaagiaaafaaceaaaaaagiaaadaaaaaa
aeababaaaaacacaaacadadaaabaeaeaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaa
aiaaacaaaaaaaaaaabaaaeaaabaaakaaaaaaaaaaacaaaaaaabaaalaaaaaaaaaa
aaacppppfbaaaaafamaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
anaaapkaaaaaaadpaaaaaaedaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaia
adaachlabpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
bpaaaaacaaaaaajaaeaiapkaafaaaaadaaaacpiaaeaafflaadaaoekaaeaaaaae
aaaacpiaacaaoekaaeaaaalaaaaaoeiaaeaaaaaeaaaacpiaaeaaoekaaeaakkla
aaaaoeiaacaaaaadaaaacpiaaaaaoeiaafaaoekaagaaaaacaaaaaiiaaaaappia
aeaaaaaeabaacdiaaaaaoeiaaaaappiaanaaaakaaiaaaaadaaaacdiaaaaaoeia
aaaaoeiaecaaaaadabaacpiaabaaoeiaaaaioekaecaaaaadacaacpiaaaaaoeia
abaioekaecaaaaadadaacpiaaaaaoelaadaioekaecaaaaadaeaacpiaaaaaoela
acaioekaecaaaaadafaacpiaaaaaoelaaeaioekaafaaaaadaaaacbiaabaappia
acaaaaiafiaaaaaeaaaacbiaaaaakkibamaakkkaaaaaaaiaacaaaaadaaaaabia
aaaaaaiaaaaaaaiaacaaaaadabaaahiaaeaaoelbakaaoekaceaaaaacacaachia
abaaoeiaacaaaaadabaaahiaaeaaoelbalaaoekaaiaaaaadabaaaiiaabaaoeia
abaaoeiaahaaaaacabaaaiiaabaappiaaeaaaaaeagaachiaabaaoeiaabaappia
acaaoeiaafaaaaadabaachiaabaappiaabaaoeiaceaaaaacahaachiaagaaoeia
aeaaaaaeagaacbiaadaappiaamaaaakaamaaffkaaeaaaaaeagaacciaadaaffia
amaaaakaamaaffkafkaaaaaeabaadiiaagaaoeiaagaaoeiaamaakkkaacaaaaad
abaaciiaabaappibamaappkaahaaaaacabaaciiaabaappiaagaaaaacagaaceia
abaappiaaiaaaaadadaacbiaabaaoelaagaaoeiaaiaaaaadadaacciaacaaoela
agaaoeiaaiaaaaadadaaceiaadaaoelaagaaoeiaaiaaaaadabaaciiaadaaoeia
ahaaoeiaalaaaaadacaaaiiaabaappiaamaakkkaabaaaaacabaaaiiaanaaffka
afaaaaadabaaaiiaabaappiaajaaaakacaaaaaadadaaaiiaacaappiaabaappia
afaaaaadabaaaiiaaeaappiaadaappiaafaaaaadaaaacoiaaeaabliaahaablka
afaaaaadaaaacoiaaaaaoeiaaaaablkaabaaaaacaeaaahiaaaaaoekaafaaaaad
aeaaahiaaeaaoeiaabaaoekaafaaaaadaeaaahiaabaappiaaeaaoeiaaiaaaaad
abaaciiaadaaoeiaabaaoeiaaeaaaaaeabaachiaadaaoeiaagaakkkaabaaoeia
aiaaaaadaeaaciiaacaaoeiaabaaoeibalaaaaadabaaabiaaeaappiaamaakkka
caaaaaadaeaaaiiaabaaaaiaagaaffkaafaaaaadaeaaaiiaaeaappiaagaaaaka
afaaaaadaeaaaiiaaaaaaaiaaeaappiaalaaaaadacaacbiaabaappiaamaakkka
aeaaaaaeabaaahiaaaaabliaacaaaaiaaeaaoeiaafaaaaadabaaaiiaafaaaaia
aeaappiaafaaaaadacaachiaabaappiaaiaaoekaafaaaaadaaaacoiaaaaaoeia
acaabliaaeaaaaaeaaaachiaabaaoeiaaaaaaaiaaaaabliaabaaaaacaaaabiia
aaaakklaafaaaaadaaaachiaaaaaoeiaaaaappiaabaaaaacaaaaciiaamaappka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcmaaiaaaaeaaaaaaadaacaaaa
fjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaafaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaa
egaobaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaamaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaa
aaaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaagaabaaaaaaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaa
aaaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaacaaaaaa
aaaaaaajocaabaaaaaaaaaaaagbjbaiaebaaaaaaafaaaaaaagijcaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaagaabaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaia
ebaaaaaaafaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
jgahbaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaah
bcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaa
aeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaa
egbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaai
bcaabaaaacaaaaaaakiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaabjaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaaoaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaagaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaa
agaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaaeaaaaaakgikcaaa
aaaaaaaaanaaaaaaegacbaaaabaaaaaabaaaaaaiccaabaaaaaaaaaaajgahbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaa
bjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahecaabaaaaaaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgakbaaaaaaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaaiocaabaaaaaaaaaaafgafbaaa
aaaaaaaaagijcaaaaaaaaaaaapaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaalmaaaaaaagaaaaaa
aaaaaaaaadaaaaaaabaaaaaaaeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Thickness] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedikocbpookhgalggmpbpiicggjhcijhpbabaaaaaafaajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbiaiaaaaeaaaaaaaagacaaaa
fjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaa
adaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
acaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaa
akiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
aoaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
agaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaa
egacbaaaabaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadeaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
anaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaadcaaaaajocaabaaa
aaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaa
afaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegacbaaaabaaaaaaeghobaaa
aeaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaabaaaaaaapaaaaahbcaabaaaabaaaaaaagaabaaa
abaaaaaapgapbaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaadaaaaaadiaaaaaiocaabaaaabaaaaaaagaabaaaaaaaaaaaagijcaaa
aaaaaaaaapaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaabaaaaaa
jgahbaaaabaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Thickness] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0_level_9_1
eefiecedommnhjgcbnafijkaihjidohjbdccecepabaaaaaaamaoaaaaaeaaaaaa
daaaaaaaoiaeaaaaaianaaaanianaaaaebgpgodjlaaeaaaalaaeaaaaaaacpppp
eiaeaaaagiaaaaaaaeaadiaaaaaagiaaaaaagiaaafaaceaaaaaagiaaaeaaaaaa
adababaaaaacacaaacadadaaabaeaeaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaa
aiaaacaaaaaaaaaaabaaaeaaabaaakaaaaaaaaaaacaaaaaaabaaalaaaaaaaaaa
aaacppppfbaaaaafamaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
anaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaia
adaachlabpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajiaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
bpaaaaacaaaaaajaaeaiapkaafaaaaadaaaachiaaeaafflaadaaoekaaeaaaaae
aaaachiaacaaoekaaeaaaalaaaaaoeiaaeaaaaaeaaaachiaaeaaoekaaeaakkla
aaaaoeiaacaaaaadaaaachiaaaaaoeiaafaaoekaaiaaaaadaaaaciiaaaaaoeia
aaaaoeiaabaaaaacabaacdiaaaaappiaecaaaaadaaaaapiaaaaaoeiaaaaioeka
ecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadacaacpiaaaaaoelaadaioeka
ecaaaaadadaacpiaaaaaoelaacaioekaecaaaaadaeaacpiaaaaaoelaaeaioeka
afaaaaadaaaacbiaaaaappiaabaaaaiaacaaaaadaaaaabiaaaaaaaiaaaaaaaia
acaaaaadabaaahiaaeaaoelbakaaoekaceaaaaacafaachiaabaaoeiaacaaaaad
abaaahiaaeaaoelbalaaoekaaiaaaaadabaaaiiaabaaoeiaabaaoeiaahaaaaac
abaaaiiaabaappiaaeaaaaaeagaachiaabaaoeiaabaappiaafaaoeiaafaaaaad
abaachiaabaappiaabaaoeiaceaaaaacahaachiaagaaoeiaaeaaaaaeagaacbia
acaappiaamaaaakaamaaffkaaeaaaaaeagaacciaacaaffiaamaaaakaamaaffka
fkaaaaaeabaadiiaagaaoeiaagaaoeiaamaakkkaacaaaaadabaaciiaabaappib
amaappkaahaaaaacabaaciiaabaappiaagaaaaacagaaceiaabaappiaaiaaaaad
acaacbiaabaaoelaagaaoeiaaiaaaaadacaacciaacaaoelaagaaoeiaaiaaaaad
acaaceiaadaaoelaagaaoeiaaiaaaaadabaaciiaacaaoeiaahaaoeiaalaaaaad
acaaaiiaabaappiaamaakkkaabaaaaacabaaaiiaajaaaakaafaaaaadabaaaiia
abaappiaanaaaakacaaaaaadafaaaiiaacaappiaabaappiaafaaaaadabaaaiia
adaappiaafaappiaafaaaaadaaaacoiaadaabliaahaablkaafaaaaadaaaacoia
aaaaoeiaaaaablkaabaaaaacadaaahiaaaaaoekaafaaaaadadaaahiaadaaoeia
abaaoekaafaaaaadadaaahiaabaappiaadaaoeiaaiaaaaadabaaciiaacaaoeia
abaaoeiaaeaaaaaeabaachiaacaaoeiaagaakkkaabaaoeiaaiaaaaadadaaciia
afaaoeiaabaaoeibalaaaaadabaaabiaadaappiaamaakkkacaaaaaadadaaaiia
abaaaaiaagaaffkaafaaaaadadaaaiiaadaappiaagaaaakaafaaaaadadaaaiia
aaaaaaiaadaappiaalaaaaadacaacbiaabaappiaamaakkkaaeaaaaaeabaaahia
aaaabliaacaaaaiaadaaoeiaafaaaaadabaaaiiaaeaaaaiaadaappiaafaaaaad
acaachiaabaappiaaiaaoekaafaaaaadaaaacoiaaaaaoeiaacaabliaaeaaaaae
aaaachiaabaaoeiaaaaaaaiaaaaabliaabaaaaacaaaabiiaaaaakklaafaaaaad
aaaachiaaaaaoeiaaaaappiaabaaaaacaaaaciiaamaappkaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcbiaiaaaaeaaaaaaaagacaaaafjaaaaaeegiocaaa
aaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaia
ebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaacaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
adaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
adaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaa
egacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaaakiacaaaaaaaaaaa
baaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaaoaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaaj
hcaabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegacbaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaabaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
deaaaaakdcaabaaaaaaaaaaamgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaanaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaa
acaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
amaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegacbaaaabaaaaaaeghobaaaaeaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaaapaaaaahbcaabaaaabaaaaaaagaabaaaabaaaaaapgapbaaa
adaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aeaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaa
diaaaaaiocaabaaaabaaaaaaagaabaaaaaaaaaaaagijcaaaaaaaaaaaapaaaaaa
diaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaa
dgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaeaeaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Thickness] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedfehnicfhmdfbpbfobdakjekdimfcegcgabaaaaaaoaaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiahaaaaeaaaaaaaokabaaaa
fjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaap
dcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaa
baaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaah
ecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaabaaaaaaaabeaaaaa
aaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaaoaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaajhcaabaaaadaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaa
aeaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaanaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaa
aaaaaaaaagajbaaaadaaaaaadiaaaaaidcaabaaaacaaaaaafgbfbaaaafaaaaaa
egiacaaaaaaaaaaaakaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaaaaaaaaa
ajaaaaaaagbabaaaafaaaaaaegaabaaaacaaaaaadcaaaaakdcaabaaaacaaaaaa
egiacaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaaegaabaaaacaaaaaaaaaaaaai
dcaabaaaacaaaaaaegaabaaaacaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaa
aaaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
jgahbaaaaaaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgcaaaaficaabaaa
aaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Thickness] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Float 208 [_Scale]
Float 212 [_Power]
Float 216 [_Distortion]
Vector 224 [_Color]
Vector 240 [_SubColor]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0_level_9_1
eefiecedipilgmeenmippnmahnghdlelaohgfddeabaaaaaaeaanaaaaaeaaaaaa
daaaaaaaimaeaaaadmamaaaaamanaaaaebgpgodjfeaeaaaafeaeaaaaaaacpppp
paadaaaageaaaaaaaeaadeaaaaaageaaaaaageaaaeaaceaaaaaageaaadaaaaaa
aaababaaacacacaaabadadaaaaaaagaaacaaaaaaaaaaaaaaaaaaajaaaiaaacaa
aaaaaaaaabaaaeaaabaaakaaaaaaaaaaacaaaaaaabaaalaaaaaaaaaaaaacpppp
fbaaaaafamaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafanaaapka
aaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachla
bpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaafaaaaad
aaaacdiaaeaafflaadaaoekaaeaaaaaeaaaacdiaacaaoekaaeaaaalaaaaaoeia
aeaaaaaeaaaacdiaaeaaoekaaeaakklaaaaaoeiaacaaaaadaaaacdiaaaaaoeia
afaaoekaecaaaaadabaacpiaaaaaoelaacaioekaecaaaaadacaacpiaaaaaoela
abaioekaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadadaacpiaaaaaoela
adaioekaacaaaaadaaaaahiaaeaaoelbakaaoekaceaaaaacaeaachiaaaaaoeia
aiaaaaadaeaaciiaalaaoekaalaaoekaahaaaaacaeaaciiaaeaappiaaeaaaaae
aaaachiaalaaoekaaeaappiaaeaaoeiaafaaaaadafaachiaaeaappiaalaaoeka
ceaaaaacagaachiaaaaaoeiaaeaaaaaeaaaacbiaabaappiaamaaaakaamaaffka
aeaaaaaeaaaacciaabaaffiaamaaaakaamaaffkafkaaaaaeaeaadiiaaaaaoeia
aaaaoeiaamaakkkaacaaaaadaeaaciiaaeaappibamaappkaahaaaaacaeaaciia
aeaappiaagaaaaacaaaaceiaaeaappiaaiaaaaadabaacbiaabaaoelaaaaaoeia
aiaaaaadabaacciaacaaoelaaaaaoeiaaiaaaaadabaaceiaadaaoelaaaaaoeia
aiaaaaadabaaciiaabaaoeiaagaaoeiaalaaaaadaeaaaiiaabaappiaamaakkka
abaaaaacabaaaiiaajaaaakaafaaaaadabaaaiiaabaappiaanaaaakacaaaaaad
afaaaiiaaeaappiaabaappiaafaaaaadabaaaiiaacaappiaafaappiaafaaaaad
aaaachiaacaaoeiaahaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoekaabaaaaac
acaaahiaaaaaoekaafaaaaadacaaahiaacaaoeiaabaaoekaafaaaaadacaaahia
abaappiaacaaoeiaaiaaaaadabaaciiaabaaoeiaafaaoeiaaeaaaaaeabaachia
abaaoeiaagaakkkaafaaoeiaaiaaaaadacaaciiaaeaaoeiaabaaoeibalaaaaad
abaaabiaacaappiaamaakkkacaaaaaadacaaaiiaabaaaaiaagaaffkaafaaaaad
acaaaiiaacaappiaagaaaakaalaaaaadadaacciaabaappiaamaakkkaaeaaaaae
abaaahiaaaaaoeiaadaaffiaacaaoeiaacaaaaadaaaaaiiaaaaappiaaaaappia
afaaaaadabaaaiiaacaappiaaaaappiaafaaaaadabaaaiiaadaaaaiaabaappia
afaaaaadacaachiaabaappiaaiaaoekaafaaaaadaaaachiaaaaaoeiaacaaoeia
aeaaaaaeaaaachiaabaaoeiaaaaappiaaaaaoeiaabaaaaacaaaabiiaaaaakkla
afaaaaadaaaachiaaaaaoeiaaaaappiaabaaaaacaaaaciiaamaappkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefckiahaaaaeaaaaaaaokabaaaafjaaaaae
egiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
ccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
aeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaed
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaaoaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaajhcaabaaaadaaaaaaegiccaaa
aaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaa
kgikcaaaaaaaaaaaanaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaa
mgaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaanaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
anaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaa
agajbaaaadaaaaaadiaaaaaidcaabaaaacaaaaaafgbfbaaaafaaaaaaegiacaaa
aaaaaaaaakaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaaaaaaaaaajaaaaaa
agbabaaaafaaaaaaegaabaaaacaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaa
aaaaaaaaalaaaaaakgbkbaaaafaaaaaaegaabaaaacaaaaaaaaaaaaaidcaabaaa
acaaaaaaegaabaaaacaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaah
icaabaaaabaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaa
aaaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgcaaaaficaabaaaaaaaaaaa
ckbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaalmaaaaaa
agaaaaaaaaaaaaaaadaaaaaaabaaaaaaaeaeaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
 Pass {
  Name "META"
  Tags { "LIGHTMODE"="Meta" "RenderType"="Opaque" }
  Cull Off
  GpuProgramID 178029
Program "vp" {
// Platform d3d9 skipped due to earlier errors
// Platform d3d9 skipped due to earlier errors
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_LightmapST;
uniform vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 vertex_1;
  vertex_1 = gl_Vertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    float tmpvar_2;
    if ((gl_Vertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((gl_MultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_5.xyz * gl_Normal.y)
  ) + (v_6.xyz * gl_Normal.z)));
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * TANGENT.xyz));
  vec3 tmpvar_10;
  tmpvar_10 = (((tmpvar_7.yzx * tmpvar_9.zxy) - (tmpvar_7.zxy * tmpvar_9.yzx)) * TANGENT.w);
  vec3 tmpvar_11;
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.y = tmpvar_10.x;
  tmpvar_11.z = tmpvar_7.x;
  vec3 tmpvar_12;
  tmpvar_12.x = tmpvar_9.y;
  tmpvar_12.y = tmpvar_10.y;
  tmpvar_12.z = tmpvar_7.y;
  vec3 tmpvar_13;
  tmpvar_13.x = tmpvar_9.z;
  tmpvar_13.y = tmpvar_10.z;
  tmpvar_13.z = tmpvar_7.z;
  gl_Position = (gl_ModelViewProjectionMatrix * vertex_1);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform float unity_OneOverOutputBoost;
uniform float unity_MaxOutputValue;
uniform float unity_UseLinearSpace;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _Color.xyz);
  vec4 res_2;
  res_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    vec4 tmpvar_3;
    tmpvar_3.w = 1.0;
    tmpvar_3.xyz = tmpvar_1;
    res_2.w = tmpvar_3.w;
    res_2.xyz = clamp (pow (tmpvar_1, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
  };
  if (unity_MetaFragmentControl.y) {
    vec3 emission_4;
    if (bool(unity_UseLinearSpace)) {
      emission_4 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_4 = vec3(0.0, 0.0, 0.0);
    };
    vec4 rgbm_5;
    vec4 tmpvar_6;
    tmpvar_6.w = 1.0;
    tmpvar_6.xyz = (emission_4 * 0.01030928);
    rgbm_5.xyz = tmpvar_6.xyz;
    rgbm_5.w = max (max (tmpvar_6.x, tmpvar_6.y), max (tmpvar_6.z, 0.02));
    rgbm_5.w = (ceil((rgbm_5.w * 255.0)) / 255.0);
    rgbm_5.w = max (rgbm_5.w, 0.02);
    rgbm_5.xyz = (tmpvar_6.xyz / rgbm_5.w);
    res_2 = rgbm_5;
  };
  gl_FragData[0] = res_2;
}


#endif
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityLightmaps" 32
Vector 0 [unity_LightmapST]
Vector 16 [unity_DynamicLightmapST]
ConstBuffer "UnityMetaPass" 32
VectorBool 0 [unity_MetaVertexControl] 4
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityLightmaps" 2
BindCB  "UnityMetaPass" 3
"vs_4_0
eefiecedgdmofobcbinpccndpoedmmkiikmbhahcabaaaaaapiahaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapadaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefccmagaaaaeaaaabaailabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafjaaaaaeegiocaaaadaaaaaaabaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaaddcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaac
adaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaaaaaaaaa
abaaaaahecaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaabhlhnbdidcaaaaal
dcaabaaaaaaaaaaaegbabaaaaeaaaaaaegiacaaaacaaaaaaaaaaaaaaogikcaaa
acaaaaaaaaaaaaaadhaaaaakhcaabaaaaaaaaaaaagiacaaaadaaaaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaaabaaaaahecaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaabhlhnbdidcaaaaaldcaabaaaabaaaaaaegbabaaaafaaaaaaegiacaaa
acaaaaaaabaaaaaaogikcaaaacaaaaaaabaaaaaadhaaaaakhcaabaaaaaaaaaaa
fgifcaaaadaaaaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaabaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "texcoord2" TexCoord2
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityLightmaps" 32
Vector 0 [unity_LightmapST]
Vector 16 [unity_DynamicLightmapST]
ConstBuffer "UnityMetaPass" 32
VectorBool 0 [unity_MetaVertexControl] 4
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityLightmaps" 2
BindCB  "UnityMetaPass" 3
"vs_4_0_level_9_1
eefiecedpocbdmcapicbjoddnlliejpjhnompefaabaaaaaammalaaaaaeaaaaaa
daaaaaaaaaaeaaaadeakaaaacmalaaaaebgpgodjmiadaaaamiadaaaaaaacpopp
fiadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaanaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaadaaagaaaaaaaaaa
abaabaaaadaaajaaaaaaaaaaacaaaaaaacaaamaaaaaaaaaaadaaaaaaabaaaoaa
ababababaaaaaaaaaaacpoppfbaaaaafapaaapkaaaaaaaaabhlhnbdiaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapja
bpaaaaacafaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaooka
amaaaaadaaaaabiaapaaaakaaaaakkjaafaaaaadaaaaaeiaaaaaaaiaapaaffka
aeaaaaaeaaaaadiaaeaaoejaamaaoekaamaaookabcaaaaaeabaaahiaaoaaaaka
aaaaoeiaaaaaoejaamaaaaadaaaaabiaapaaaakaabaakkiaafaaaaadaaaaaeia
aaaaaaiaapaaffkaaeaaaaaeaaaaadiaafaaoejaanaaoekaanaaookabcaaaaae
acaaahiaaoaaffkaaaaaoeiaabaaoeiaafaaaaadaaaaapiaacaaffiaadaaoeka
aeaaaaaeaaaaapiaacaaoekaacaaaaiaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
acaakkiaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaafaaaaad
aaaaahiaabaaffjaahaamjkaaeaaaaaeaaaaahiaagaamjkaabaaaajaaaaaoeia
aeaaaaaeaaaaahiaaiaamjkaabaakkjaaaaaoeiaaiaaaaadaaaaaiiaaaaaoeia
aaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadaaaaahiaaaaappiaaaaaoeia
abaaaaacabaaaboaaaaakkiaafaaaaadabaaaciaacaaaajaajaaaakaafaaaaad
abaaaeiaacaaaajaakaaaakaafaaaaadabaaabiaacaaaajaalaaaakaafaaaaad
acaaaciaacaaffjaajaaffkaafaaaaadacaaaeiaacaaffjaakaaffkaafaaaaad
acaaabiaacaaffjaalaaffkaacaaaaadabaaahiaabaaoeiaacaaoeiaafaaaaad
acaaaciaacaakkjaajaakkkaafaaaaadacaaaeiaacaakkjaakaakkkaafaaaaad
acaaabiaacaakkjaalaakkkaacaaaaadabaaahiaabaaoeiaacaaoeiaaiaaaaad
aaaaaiiaabaaoeiaabaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahia
aaaappiaabaaoeiaafaaaaadacaaahiaaaaaoeiaabaaoeiaaeaaaaaeacaaahia
abaanciaaaaamjiaacaaoeibafaaaaadacaaahiaacaaoeiaabaappjaabaaaaac
abaaacoaacaaaaiaabaaaaacabaaaeoaabaaffiaabaaaaacacaaaboaaaaaaaia
abaaaaacadaaaboaaaaaffiaabaaaaacacaaacoaacaaffiaabaaaaacadaaacoa
acaakkiaabaaaaacacaaaeoaabaakkiaabaaaaacadaaaeoaabaaaaiappppaaaa
fdeieefccmagaaaaeaaaabaailabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaa
fjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaa
fjaaaaaeegiocaaaadaaaaaaabaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaaddcbabaaaaeaaaaaafpaaaaaddcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacadaaaaaa
dbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaaaaaaaaaabaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaabhlhnbdidcaaaaaldcaabaaa
aaaaaaaaegbabaaaaeaaaaaaegiacaaaacaaaaaaaaaaaaaaogikcaaaacaaaaaa
aaaaaaaadhaaaaakhcaabaaaaaaaaaaaagiacaaaadaaaaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaaabaaaaahecaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
bhlhnbdidcaaaaaldcaabaaaabaaaaaaegbabaaaafaaaaaaegiacaaaacaaaaaa
abaaaaaaogikcaaaacaaaaaaabaaaaaadhaaaaakhcaabaaaaaaaaaaafgifcaaa
adaaaaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaabaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaa
jgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaa
acaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaa
adaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaa
dgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaa
bkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaaf
cccabaaaaeaaaaaackaabaaaacaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaoaaaaaaa
acaaaaaaaaaaaaaaadaaaaaaafaaaaaaapadaaaaoaaaaaaaadaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
}
Program "fp" {
// Platform d3d9 skipped due to earlier errors
// Platform d3d9 skipped due to earlier errors
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 224
Vector 160 [_Color]
Float 196 [unity_OneOverOutputBoost]
Float 200 [unity_MaxOutputValue]
ConstBuffer "UnityMetaPass" 32
VectorBool 16 [unity_MetaFragmentControl] 4
BindCB  "$Globals" 0
BindCB  "UnityMetaPass" 1
"ps_4_0
eefiecedpglndnmjcapeibkneomhkkahojpgmjlgabaaaaaakmacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefckeabaaaaeaaaaaaagjaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaakaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaa
aaaaaaaadgcaaaagicaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaabjaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaddaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
kgikcaaaaaaaaaaaamaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
dhaaaaanpcaabaaaaaaaaaaaagiacaaaabaaaaaaabaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadhaaaaanpccabaaaaaaaaaaa
fgifcaaaabaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaambmamadm
egaobaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 224
Vector 160 [_Color]
Float 196 [unity_OneOverOutputBoost]
Float 200 [unity_MaxOutputValue]
ConstBuffer "UnityMetaPass" 32
VectorBool 16 [unity_MetaFragmentControl] 4
BindCB  "$Globals" 0
BindCB  "UnityMetaPass" 1
"ps_4_0_level_9_1
eefieceddkdlplaamaghigghlnecjiaijdpncddkabaaaaaabmaeaaaaaeaaaaaa
daaaaaaajmabaaaaeiadaaaaoiadaaaaebgpgodjgeabaaaageabaaaaaaacpppp
biabaaaaemaaaaaaadaaciaaaaaaemaaaaaaemaaabaaceaaaaaaemaaaaaaaaaa
aaaaakaaabaaaaaaaaaaaaaaaaaaamaaabaaabaaaaaaaaaaabaaabaaabaaacaa
ababababaaacppppfbaaaaafadaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaknhkddm
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpia
aaaaoelaaaaioekaabaaaaacaaaabiiaabaaffkaafaaaaadaaaachiaaaaaoeia
aaaaoekaapaaaaacabaaabiaaaaaaaiaapaaaaacabaaaciaaaaaffiaapaaaaac
abaaaeiaaaaakkiaafaaaaadaaaaahiaaaaappiaabaaoeiaaoaaaaacabaacbia
aaaaaaiaaoaaaaacabaacciaaaaaffiaaoaaaaacabaaceiaaaaakkiaakaaaaad
aaaachiaabaakkkaabaaoeiaabaaaaacabaaadiaacaaoekafiaaaaaeaaaachia
abaaaaibadaaaakaaaaaoeiaabaaaaacaaaaaiiaacaaaakafiaaaaaeaaaacpia
abaaffibaaaaoeiaadaaoekaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
keabaaaaeaaaaaaagjaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaakaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
dgcaaaagicaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaabjaaaaafhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaddaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaakgikcaaa
aaaaaaaaamaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpdhaaaaan
pcaabaaaaaaaaaaaagiacaaaabaaaaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadhaaaaanpccabaaaaaaaaaaafgifcaaa
abaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaambmamadmegaobaaa
aaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Bumped Diffuse"
}