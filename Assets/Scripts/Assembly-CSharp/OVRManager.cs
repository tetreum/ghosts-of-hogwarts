using UnityEngine;

public class OVRManager : MonoBehaviour
{
	public float nativeTextureScale;
	public float virtualTextureScale;
	public bool usePositionTracking;
	public RenderTextureFormat eyeTextureFormat;
	public int eyeTextureDepth;
	public bool timeWarp;
	public bool freezeTimeWarp;
	public bool resetTrackerOnLoad;
	public bool monoscopic;
}
