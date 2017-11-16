using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

public class itween_demo : MonoBehaviour {
    //  Vector3[] path;

    public string pathName = "";
    public Transform[] grind;

    PlayerMovement grindDetect;
    
    float minDistance = float.PositiveInfinity;
    float minPercent = 0;
    public bool onPath;
    public GameObject player;
    float current;
    float dist;
    float t;
    RaycastHit hitForLanding;
    // Use this for initialization

    void Awake() {

        player = GameObject.FindGameObjectWithTag("Player");
    }
    public void detectGrind(/*GameObject player*/) {


        for (t = 0; t <= 1; t += 0.02f) {
            dist = Vector3.Distance(player.transform.position, iTween.PointOnPath(grind, t));
            if (dist < minDistance) {
                minDistance = dist;
                minPercent = t;
            }

        }
        iTween.PutOnPath(player, grind, minPercent);
        onPath = true;
    }


    public void moveAlongPath(float speed /*GameObject player*/) {

        if (onPath) {
            if (speed > 0) {
                minPercent += speed * Time.deltaTime;
                if (minPercent > current)
                    current = minPercent;
                iTween.PutOnPath(player, grind, current);
            }
            //grindDetect.grind = false;
        }
    }


    public void endGrind(PlayerMovement g ) {

        if (Input.GetButtonDown("Jump") || current >= 1) {
            onPath = false;
            g.grind = false;

            minPercent = 0;
            current = 0;
            minDistance = float.PositiveInfinity;
            
            //dist = 0;
            //t = 0;
            //v = 0;
        }

    }

    void OnDrawGizmos() {

        iTween.DrawPath(grind, Color.magenta);
    }


}
