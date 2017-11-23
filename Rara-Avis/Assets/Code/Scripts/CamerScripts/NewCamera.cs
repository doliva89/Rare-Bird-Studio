using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewCamera : MonoBehaviour {

    [SerializeField]
    private Transform target = null;
    [SerializeField]
    private float distance = 3.0f;
    [SerializeField]
    private float height = 1.0f;
    [SerializeField]
    private float damping = 5.0f;
    
     // allows offset of the bumper ray from target origin
    PlayerMovement speed;
    
    public Transform player;
    public Camera main;
    /// <Summary>
    /// If the target moves, the camera should child the target to allow for smoother movement. DR
    /// </Summary>
    private void Awake() { 
        speed = GameObject.FindGameObjectWithTag("Player").GetComponent<PlayerMovement>();
        main = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<Camera>();
      

    }


    private void FixedUpdate() {
        Vector3 wantedPosition = transform.position + transform.TransformDirection(0, 0, -distance);// = transform.TransformPoint(0, height, -distance);

        // check to see if there is anything behind the target
        RaycastHit hit;
        Vector3 back = target.transform.TransformDirection(-1 * Vector3.forward);
        float rightH = Input.GetAxis("RightThumb");
        float rightV = Input.GetAxis("RightThumbV");

        Vector3 lookhere = new Vector3(/*(3 * Time.deltaTime) **/ rightV * 3, /*(3*Time.deltaTime)**/rightH * 3, 0);

        float xVal = transform.localEulerAngles.x;
        if (xVal > 180)
            xVal -= 360;
        transform.localEulerAngles = new Vector3(
            Mathf.Clamp(xVal + lookhere.x, -45, 75),
            transform.localEulerAngles.y + lookhere.y,
            0);

        Ray ray = new Ray(transform.position, transform.TransformDirection(0, 0, -distance));

        // cast the bumper ray out from rear and check to see if there is anything behind
        if (Physics.Raycast(ray, out hit, Vector3.Distance(transform.position, transform.position + transform.TransformDirection(0, 0, -distance)))
            && hit.transform != transform && !hit.transform.gameObject.CompareTag("Player") && !hit.transform.gameObject.CompareTag("Foliage")) // ignore ray-casts that hit the user. DR
        {
            float dist = Vector3.Distance(hit.point, transform.position);
            wantedPosition = ray.GetPoint(dist - 0.5f);
           // Debug.DrawRay(transform.TransformPoint(bumperRayOffset), -transform.forward, Color.magenta);

        }

        float rotVal = Mathf.Clamp(speed.speed, 0, 20);
        if (rotVal > 1)
            rotVal = 0;
        Quaternion playerRot = player.rotation;

        playerRot.x = playerRot.x - .02f;
        playerRot.z = 0;


        main.transform.position = Vector3.Lerp(main.transform.position, wantedPosition, Time.deltaTime * damping);
        if (speed.sliding) {
            transform.rotation = /*transform.rotation;*/Quaternion.Slerp(transform.rotation, playerRot, Time.deltaTime *.7f);
        }
    }
}
