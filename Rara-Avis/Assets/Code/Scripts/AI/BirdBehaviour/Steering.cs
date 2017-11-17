using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Steering : MonoBehaviour {

    public float maxVelocity = 1f;
    public float maxForce = 1f;
    public float maxSpeed = 1f;
    public float mass = 1f;
    public float slowRadius = 1f;
    public float maxSeeAhead = 4f;
    public float maxAvoidanceForce = 1f;
    public float maxSeperation = 1f;
    public float seperationRadius = 1f;
    public Vector3 targetPlayerPosition = Vector3.zero;
    public float whenToFlee = 2.0f;
    public float whenToStopFleeing = 20.0f;

    private GameObject player;
    private Vector3 ahead, ahead2;
    private Vector3 targetPlayer;
    private float distance;
    public bool fleeing = false;

    // Use this for initialization
    void Start () {
        player = GameObject.FindGameObjectWithTag("Player");
        targetPlayer = player.transform.TransformPoint(targetPlayerPosition);
        distance = Vector3.Distance(transform.position, targetPlayer);

    }

    // Update is called once per frame
    void Update() {
        CalculateAhead();
        targetPlayer = player.transform.TransformPoint(targetPlayerPosition);
        distance = Vector3.Distance(transform.position, targetPlayer);

        if(distance <= whenToFlee) fleeing = true;
        if (distance >= whenToStopFleeing) fleeing = false;

        if(fleeing) Flee(player.transform.position);
        if(!fleeing) Seek(targetPlayer, slowRadius);
	}

    public void Seek(Vector3 target, float radius)
    {
        Vector3 position = transform.position;
        Vector3 velocity = Vector3.zero;
        Vector3 desiredVelocity = Vector3.zero;
        Vector3 steering = Vector3.zero;

        velocity = Vector3.Normalize(target - position) * maxVelocity;


        if (Vector3.Distance(target, position) < radius)
        {
            desiredVelocity = Vector3.Normalize(target - position) * maxVelocity * (Vector3.Distance(target, position)/radius);
        }
        else
        {
            desiredVelocity = Vector3.Normalize(target - position) * maxVelocity;
        }

        steering = desiredVelocity - velocity;

        
        steering = Vector3.ClampMagnitude(steering, maxForce);
        steering = steering + collisionAvoidance() + Seperation();
        steering = steering / mass;
        velocity = Vector3.ClampMagnitude(velocity + steering, maxSpeed);

        transform.position = position + velocity * Time.deltaTime;
        transform.LookAt(targetPlayer);
    }

    void Flee(Vector3 target)
    {
        Vector3 position = transform.position;
        Vector3 velocity = Vector3.zero;
        Vector3 desiredVelocity = Vector3.zero;
        Vector3 steering = Vector3.zero;

        velocity = Vector3.Normalize(position - target) * maxVelocity;

        desiredVelocity = Vector3.Normalize(position - target) * maxVelocity;

        steering = desiredVelocity - velocity;
        steering = Vector3.ClampMagnitude(steering, maxForce);
        steering = steering + collisionAvoidance() + Seperation();
        steering = steering / mass;
        velocity = Vector3.ClampMagnitude(velocity + steering, maxSpeed);

        transform.position = position + velocity * Time.deltaTime;
        transform.LookAt(-targetPlayer);
    }

    void CalculateAhead()
    {
        Vector3 velocity = Vector3.Normalize(transform.position+transform.forward - transform.position);
        float dynamicLength = velocity.magnitude / maxVelocity;


        ahead = transform.position + Vector3.Normalize(velocity) * maxSeeAhead;
        ahead2 = transform.position + Vector3.Normalize(velocity) * maxSeeAhead * 0.5f;
    }

    Vector3 collisionAvoidance()
    {
        GameObject mostThreatening = findMostThreateningObstacle();
        Vector3 avoidance = Vector3.zero;

        if (mostThreatening != null)
        {
            avoidance += ahead - mostThreatening.transform.position;
            avoidance.Normalize();
            avoidance.Scale(Vector3.one * maxAvoidanceForce);
        }
        else
        {
            avoidance.Scale(Vector3.zero);
        }

        return avoidance;
    }

    GameObject findMostThreateningObstacle()
    {
        GameObject mostThreatening = null;
        GameObject[] objects = GameObject.FindObjectsOfType(typeof(GameObject)) as GameObject[];

        for (int i = 0; i < objects.Length; i++)
        {
            GameObject obstacle = objects[i];

            bool collision = lineIntersectsCircle(ahead, ahead2, obstacle);
            if (collision && (mostThreatening == null || Vector3.Distance(transform.position, obstacle.transform.position) < Vector3.Distance(transform.position, mostThreatening.transform.position)))
            {
                mostThreatening = obstacle;
            }
        }

        return mostThreatening;
    }

    bool lineIntersectsCircle(Vector3 a, Vector3 b, GameObject go)
    {
        if (go.GetComponent<Collider>() != null)
        {
            Collider col = go.GetComponent<Collider>();
            float radius = col.bounds.extents.magnitude;
            return Vector3.Distance(go.transform.position, a) <= radius || Vector3.Distance(go.transform.position, b) <= radius;
        }
        else
            return false;
    }

    Vector3 Seperation()
    {
        Vector3 force = Vector3.zero;

        int neighbourCount = 0;

        GameObject[] objects = GameObject.FindGameObjectsWithTag("Bird");

        float dist;

        for (int i = 0; i < objects.Length; i++)
        {
            if (objects[i] != this)
            {
                dist = Vector3.Distance(objects[i].transform.position, this.transform.position);
                if (dist <= seperationRadius)
                {
                    force = force + (this.transform.position - objects[i].transform.position);
                    //force = objects[i].transform.position - this.transform.position;
                    neighbourCount++;
                }
            }
        }

        if (neighbourCount != 0)
        {
            force /= neighbourCount;
            force = Vector3.ClampMagnitude(force, -1);
        }

        force.Normalize();
        force = Vector3.ClampMagnitude(force, maxSeperation);

        return force;
    }

    void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.blue;
        Gizmos.DrawLine(transform.position, ahead2);
        Gizmos.color = Color.red;
        Gizmos.DrawLine(ahead2, ahead);
    }

}
