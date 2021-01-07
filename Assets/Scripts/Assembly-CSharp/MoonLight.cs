using UnityEngine;

public class MoonLight : MonoBehaviour
{
	private void Start() {
		if (QualitySettings.GetQualityLevel() == 0 || QualitySettings.GetQualityLevel() == 1) {
			base.GetComponent<Light>().intensity = 0f;
			base.enabled = false;

		}
	}
}
