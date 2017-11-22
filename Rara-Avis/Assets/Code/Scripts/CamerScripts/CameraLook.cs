using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraLook : MonoBehaviour {

    public Transform main;

    void Start() {
        main = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<Transform>();
    }

    void Update() {

        transform.rotation = main.transform.rotation;
    }
}
