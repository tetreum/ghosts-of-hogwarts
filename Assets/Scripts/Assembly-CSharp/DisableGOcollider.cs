using UnityEngine;

public class DisableGOcollider : MonoBehaviour
{
    private void Start() {
        showChilds(false);
    }

    private void OnTriggerEnter(Collider other) {
        showChilds(true);
    }

    private void OnTriggerExit(Collider other) {
        showChilds(false);
    }
    public void showChilds (bool enabled) {
        for (int index = 0; index < this.transform.childCount; ++index) {
            this.transform.GetChild(index).gameObject.SetActive(enabled);
        }
    }
}
