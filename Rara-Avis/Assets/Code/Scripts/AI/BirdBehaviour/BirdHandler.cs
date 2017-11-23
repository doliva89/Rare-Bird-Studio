using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BirdHandler : MonoBehaviour {

    public float distanceFromPlayer = 20f;
    public GameObject bird;
    public float spawnTime = 5f;
    public int maxBirds = 10;
    public Vector3 birdSpawnFromPlayer = Vector3.zero;
    public float maxDistanceToDespawn = 30f;
    public float speedToSpawnBird = 0.2f;

    private PlayerMovement player;
    private float time = 0f;
    private int amountOfBirds = 0;
    private Vector3 birdSpawnPoint = Vector3.zero;
    private List<GameObject> birds;

	// Use this for initialization
	void Start () {
        player = FindObjectOfType<PlayerMovement>();
        birds = new List<GameObject>();
        birdSpawnPoint = player.transform.TransformPoint(birdSpawnFromPlayer);
	}
	
	// Update is called once per frame
	void Update () {
        time += Time.deltaTime * player.Multiplier;
        birdSpawnPoint = player.transform.TransformPoint(birdSpawnFromPlayer);

        if (time > spawnTime && player.speed > speedToSpawnBird && amountOfBirds != maxBirds)
        {
            SpawnBird();
        }

        if (birds.Count >= 1 && amountOfBirds != 0)
        {
            DespawnBird();
        }
	}

    void SpawnBird()
    {
        time = 0;
        birds.Add(Instantiate(bird, birdSpawnPoint, Quaternion.identity) as GameObject);
        amountOfBirds += 1;
    }

    public void DespawnBird()
    {
        for(int i = 0; i < birds.Count; i++)
        {
            float distance = birds[i].GetComponent<Steering>().distance;
            if(distance >= maxDistanceToDespawn)
            {
                GameObject remove = birds[i];
                birds.Remove(remove);
                amountOfBirds -= 1;
                Destroy(remove);
            }
        }
    }
}
