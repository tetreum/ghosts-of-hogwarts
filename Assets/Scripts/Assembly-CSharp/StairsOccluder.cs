using UnityEngine;

// Token: 0x0200005C RID: 92
public class StairsOccluder : MonoBehaviour
{
	// Token: 0x060001BA RID: 442 RVA: 0x0000A2C0 File Offset: 0x000084C0
	private void OnTriggerEnter(Collider other) {
		base.GetComponent<OcclusionPortal>().open = false;
		Debug.Log(base.GetComponent<OcclusionPortal>().open);
	}

	// Token: 0x060001BB RID: 443 RVA: 0x0000A2F0 File Offset: 0x000084F0
	private void OnTriggerExit(Collider other) {
		base.GetComponent<OcclusionPortal>().open = true;
		Debug.Log(base.GetComponent<OcclusionPortal>().open);
	}
}
