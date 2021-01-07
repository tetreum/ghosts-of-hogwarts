using UnityEngine;
using UnityEngine.UI;

public class SettingsPanel : MonoBehaviour
{
    public Text mouseSpeed;
    public Slider speedSlider;

    private void OnDisable() {
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
    }

    private void OnEnable() {
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
    }

    public void speed () {
        OVRPlayerController.Instance.lookSpeed = speedSlider.value;
        mouseSpeed.text = speedSlider.value.ToString();
    }

    public void close () {
        gameObject.SetActive(false);
    }
}
