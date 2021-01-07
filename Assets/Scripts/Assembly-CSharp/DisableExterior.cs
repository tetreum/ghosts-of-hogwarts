using System;
using UnityEngine;

// Token: 0x02000006 RID: 6
public class DisableExterior : MonoBehaviour
{
	// Token: 0x0600000C RID: 12 RVA: 0x00002658 File Offset: 0x00000858
	private void Start() {
		this.HogwartExt.SetActive(false);
	}

	// Token: 0x0600000D RID: 13 RVA: 0x00002668 File Offset: 0x00000868
	private void OnTriggerEnter(Collider other) {
		this.HogwartExt.SetActive(true);
	}

	// Token: 0x0600000E RID: 14 RVA: 0x00002678 File Offset: 0x00000878
	private void OnTriggerExit(Collider other) {
		this.HogwartExt.SetActive(false);
	}

	// Token: 0x04000011 RID: 17
	public GameObject HogwartExt;
}
