using UnityEngine;

public class Water : MonoBehaviour
{
	public enum WaterMode
	{
		Simple = 0,
		Reflective = 1,
		Refractive = 2,
	}

	public WaterMode m_WaterMode;
	public bool m_DisablePixelLights;
	public int m_TextureSize;
	public float m_ClipPlaneOffset;
	public LayerMask m_ReflectLayers;
	public LayerMask m_RefractLayers;
}
