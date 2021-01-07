using System;
using UnityEngine;

// Token: 0x0200005F RID: 95
public class Tourne : MonoBehaviour
{
	// Token: 0x060001C2 RID: 450 RVA: 0x0000A5B0 File Offset: 0x000087B0
	private void Update() {
		base.transform.Rotate(this.sens * Time.deltaTime * this.vitesse);
	}

	// Token: 0x040002A4 RID: 676
	public float vitesse;

	// Token: 0x040002A5 RID: 677
	public Vector3 sens;
}
