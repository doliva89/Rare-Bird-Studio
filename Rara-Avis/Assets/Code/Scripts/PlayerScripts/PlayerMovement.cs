using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class PlayerMovement : MonoBehaviour {

    itween_demo pathScript;
    public string path;
    public float walkSpeed;
    public float runSpeed;

    public float initialJumpForce;
    public float continJumpForce;
    public float negativeJumpForce;
    public float Maxjumpcharge;

    public float slideStartAngel;
    public float Multiplier;
    public float speedBonusRun;
    public float speedBonuswalk;
    public float slideMultiAdditon;
    public float burm;

    public float chargetimer;
    public float chargetime;
    public float glideForce;

    public float plusGravity;
    public float minusGravity;

    public float succRunClickMax;
    public float succRunfulClickMin;
    public float failRunClickMax;
    public float failRunClickMin;

    public float succSlideClickMax;
    public float succSlidefulClickMin;
    public float failSlideClickMax;
    public float failSlideClickMin;

    public float succGrindClickMax;
    public float succGrindfulClickMin;
    public float failGrindClickMax;
    public float failGrindClickMin;
    public bool sliding;
    public bool grind;
    [SerializeField]
    public float speed;
    Camera cam;

    Rigidbody rb;
    Vector3 moveDir;
    Vector3 slidingForce;
    Vector3 globalForce;
    Vector3 directionOfRoll;
    Vector3 oldPos;
    private Animator animator;
    private RaycastHit hit;

    Quaternion currentRot;
    private float gravity;
    private float movementSpeed;
    private float _doubleTapTimeA;
    private float _doubleTapTimeD;
    private float worldForwardAngle;
    private float worldRightAngle;
    private float jumpCharger;
    Animator playerAnim;
    private int jump = 0;


    private bool running;
    private bool clicked;
    private bool negativeGravity;
    private bool m_grounded;
    private bool doubleTapA = false;
    private bool doubleTapD = false;
    float time;
    float blendX;
    float blendY;


    void Start() {

        globalForce = Vector3.zero;
        rb = GetComponent<Rigidbody>();
        playerAnim = GameObject.FindGameObjectWithTag("kid").GetComponent<Animator>();
       // gravity = .87f;
        cam = Camera.main;

    }

    void Update() {
        float v = Input.GetAxis("Vertical");
        Jump();
        Landing();
        if (Input.GetMouseButton(0) && m_grounded || Input.GetButton("Slide") && m_grounded) {
            sliding = true;
            running = false;
        }
        else if (Input.GetButtonUp("Slide")) {
            sliding = false;
        }
        pathScript.detectGrind(gameObject);
        movePlayerOnPath(v);

    }

    void FixedUpdate() {


        ///Jump();

        float h = Input.GetAxis("Horizontal");
        float v = Input.GetAxis("Vertical");
       
        blendX = playerAnim.GetFloat("blendX");
        blendY = playerAnim.GetFloat("blendY");
        time += Time.deltaTime;
        if (time >= .5) {
            speed = Vector3.Distance(oldPos, transform.position) * 10;
            time = 0;
        }

        m_grounded = IsGrounded();
        checkForSlopes();
        Movement(h, v);
        //  Landing();
        //checkForSlopes();
        calculatingAngles();
        calculatingMultiplyer();


       // speed = Vector3.Distance(oldPos, transform.position) * 10;
        oldPos = transform.position;

        playerAnim.SetBool("jumpIsTrue", !m_grounded);
        print(speed);
    }


    bool IsGrounded() {

        Ray ray = new Ray(transform.position, -transform.up);

        //Raycast to check if the player is grounded or not
        if (Physics.Raycast(ray, out hit, .8f)) {

            if (hit.collider.tag == "Map" || hit.collider.tag == "Grind") {
                chargetimer = 0;
                negativeGravity = false;

                //Physics.gravity = new Vector3(0, -9.87f, 0);
                return true;
            }
        }
        // sliding = false;
        return false;
    }

    void Movement(float x, float v) {

        if (Input.GetKey(KeyCode.LeftShift) || Input.GetButton("Run") && m_grounded) {
            running = true;
            sliding = false;


        }
        else {
            running = false;
        }


        if (running) {
            movementSpeed = runSpeed + (Multiplier * speedBonusRun); ;


        }
        else {
            movementSpeed = walkSpeed + (Multiplier * speedBonuswalk); ;

        }

        if (sliding) {
            //The Player is sliding
            //float xProj = animator.GetFloat("xProj");
           
            playerAnim.SetBool("isSliding", true);
            playerAnim.SetFloat("blendX", x);
            playerAnim.SetFloat("blendY", v);
            moveDir = transform.TransformDirection(blendX /** movementSpeed*/, 0, blendY/* * movementSpeed*/);
            rb.MovePosition(transform.position + (moveDir * movementSpeed * (speed / 3f) * Time.deltaTime));
            //rb.AddForce(moveDir * Time.deltaTime, ForceMode.VelocityChange);
        }

        if (!sliding) {

            playerAnim.SetBool("isSliding", false);
            //The Player is running
            // Vector3 _input = new Vector3(Input.GetAxis("Horizontal") * 3, 0, Input.GetAxis("Horizontal") * 3);

            //Vector3 _moveDir = cam.transform.TransformDirection(_input);
            // moveDir = transform.TransformDirection(0, 0, Mathf.Clamp(Mathf.Abs(v + x),-1,1)   /*Mathf.Abs*x)/*-1,1)*/ * movementSpeed);
            if (v != 0 || x != 0)
                //rb.MovePosition(transform.position + (transform.forward* movementSpeed * Time.deltaTime));
                rb.MovePosition(transform.position + (transform.forward * movementSpeed * Time.deltaTime));

            playerAnim.SetFloat("walkSpeed", Mathf.Abs(v + x));

        }

    }


    void Jump() {
        //Player jumps up
        if (Input.GetButtonDown("Jump") && m_grounded == true) {


            playerAnim.SetBool("failedLanding", false);

            gravity = 0.87f;
            rb.AddForce(transform.up * initialJumpForce, ForceMode.VelocityChange);
        }

        if (Input.GetButton("Jump")) {
            jumpCharger += Time.deltaTime;
            if (jumpCharger < Maxjumpcharge) {
                rb.AddForce(transform.up * continJumpForce, ForceMode.Force);
            }
            if (jumpCharger > Maxjumpcharge)
                negativeGravity = true;
        }
        if (Input.GetButtonUp("Jump")) {


            m_grounded = false;
            running = false;
            sliding = false;
            jump = 1;
            gravity = 0.87f;
            jumpCharger = 0;
            negativeGravity = true;

        }
        if (m_grounded == false) {
            chargetimer += Time.deltaTime;

            //Code for player to  glide.
            //Gravity gets lighter
            if (Input.GetKey(KeyCode.E) && chargetimer < chargetime && !sliding || Input.GetButton("Glide") && chargetimer < chargetime && !sliding) {
                gravity += plusGravity;
                //Physics.gravity = new Vector3(0, gravity, 0);
                rb.velocity = glideForce * transform.forward;
                // rb.AddForce(transform.forward * 10, ForceMode.VelocityChange);

            }
            //Code that brings player back down
            //Gravity gets heavier
            if (Input.GetKeyUp(KeyCode.E) || Input.GetButtonUp("Glide") || chargetimer >= 2) {
                gravity -= minusGravity;
            }


        }
        if (m_grounded) {
            gravity = -9.87f;
        }

        Physics.gravity = new Vector3(0, gravity, 0);
        if (negativeGravity)
            rb.AddForce(-transform.up * negativeJumpForce, ForceMode.VelocityChange);
    }



    void checkForSlopes() {

        float v = Input.GetAxis("Vertical");
        float h = Input.GetAxis("Horizontal");


        //Move player around based on the players mouse
        //float mouseInput = Input.GetAxis("Mouse X");
        Vector3 lookhere1 = cam.transform.TransformDirection(new Vector3(Input.GetAxis("Horizontal") * 3, 0, Input.GetAxis("Vertical") * 3));

        Quaternion lookRot = Quaternion.LookRotation(lookhere1);
        if (lookRot.y != 0) {
            currentRot = lookRot;

        }

        //If player is grounded slerp the player with the terrains normal
        if (m_grounded && !sliding) {
            Quaternion targetRotation = Quaternion.FromToRotation(transform.up, hit.normal) * transform.rotation;

            targetRotation = Quaternion.Euler(targetRotation.eulerAngles.x, currentRot.eulerAngles.y, targetRotation.eulerAngles.z);
            transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, (Time.deltaTime * 20) /* (Mathf.Clamp(v + Mathf.Abs(h), 0f, 1))*/);
        }

        if (m_grounded && sliding) {
            Quaternion targetRotation = Quaternion.FromToRotation(transform.up, hit.normal) * transform.rotation;

            targetRotation = Quaternion.Euler(targetRotation.eulerAngles.x, targetRotation.eulerAngles.y, targetRotation.eulerAngles.z);
            transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, (Time.deltaTime * 20));
        }

        ////If the player isn't grounded rotate them so there transform up is the same as the worlds up
        else {
            Quaternion targetRotation = Quaternion.FromToRotation(transform.up, Vector3.up) * transform.rotation;
            targetRotation = Quaternion.Euler(targetRotation.eulerAngles.x, currentRot.eulerAngles.y, targetRotation.eulerAngles.z);
            transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, Time.deltaTime /** (Mathf.Clamp(v + Mathf.Abs(h), 0f, 1))*/ * 10);
        }
    }

    void calculatingAngles() {

        //Turns on/off the sliding mechanic


        //Sliding turned on will calculate global force to apply to player 
        if (sliding) {
            float forwardAngle = Vector3.Angle(transform.up, Vector3.forward);
            worldForwardAngle = forwardAngle - 90;


            float Rightangle = Vector3.Angle(transform.up, Vector3.right);
            worldRightAngle = Rightangle - 90;


            if (worldForwardAngle > slideStartAngel)
                slidingForce.z = -(worldForwardAngle - slideStartAngel) * Multiplier;

            else if (worldForwardAngle < -slideStartAngel)
                slidingForce.z = Mathf.Abs((worldForwardAngle + slideStartAngel) * Multiplier);

            else slidingForce.z = 0;

            if (worldRightAngle > slideStartAngel)
                slidingForce.x = -(worldRightAngle - slideStartAngel) * Multiplier;
            else if (worldRightAngle < -slideStartAngel)
                slidingForce.x = Mathf.Abs((worldRightAngle + slideStartAngel) * Multiplier);
            else
                slidingForce.x = 0;
            globalForce = slidingForce;

        }
        //the Player is running 
        if (!sliding) {
            globalForce = Vector3.zero;
        }
        rb.AddForce(globalForce, ForceMode.Force);

    }

    void Landing() {


        RaycastHit hitForLanding;
        Vector3 down = transform.TransformDirection(Vector3.down);

        if (!m_grounded && !clicked) {

            if (Physics.Raycast(transform.position, down, out hitForLanding)) {
                //Range in which the player can preform a time click to land correctly
                if (hitForLanding.distance <= succRunClickMax && hitForLanding.distance >= succRunfulClickMin && Input.GetMouseButtonDown(0) || hitForLanding.distance <= succRunClickMax && hitForLanding.distance >= succRunfulClickMin && Input.GetButtonDown("LandRun")) {
                    jump = 2;
                    clicked = true;
                    running = true;

                    //  print("landed");
                }
                //Outside of above range is a failed click and landing
                if (hitForLanding.distance > failRunClickMax && Input.GetMouseButtonDown(0) || hitForLanding.distance < failRunClickMin && Input.GetMouseButtonDown(0) || hitForLanding.distance > failRunClickMax && Input.GetButtonDown("LandRun") || hitForLanding.distance < failRunClickMin && Input.GetButtonDown("LandRun")) {
                    jump = 1;
                    clicked = true;
                    //  print("didnt land");
                    playerAnim.SetBool("failedLanding", true);
                }

                if (hitForLanding.distance <= succSlideClickMax && hitForLanding.distance >= succRunfulClickMin && Input.GetMouseButtonDown(0) || hitForLanding.distance <= succSlideClickMax && hitForLanding.distance >= succSlidefulClickMin && Input.GetButtonDown("LandSlide") && hitForLanding.collider.tag == "Map") {
                    jump = 2;
                    clicked = true;
                    sliding = true;
                    //  print("landed");
                }
                //Outside of above range is a failed click and landing
                if (hitForLanding.distance > failSlideClickMax && Input.GetMouseButtonDown(0) || hitForLanding.distance < failSlideClickMin && Input.GetMouseButtonDown(0) || hitForLanding.distance > failSlideClickMax && Input.GetButtonDown("LandSlide") && hitForLanding.collider.tag == "Map" || hitForLanding.distance < failSlideClickMin && Input.GetButtonDown("LandSlide") && hitForLanding.collider.tag == "Map") {
                    jump = 1;
                    clicked = true;
                    //print("didnt land");
                    playerAnim.SetBool("failedLanding", true);
                }

                if (hitForLanding.distance <= succGrindClickMax && hitForLanding.distance >= succGrindfulClickMin && Input.GetButtonDown("LandGrind") && hitForLanding.collider.tag == "Grind") {
                    jump = 2;
                    clicked = true;
                    grind = true;
                    if (hitForLanding.transform.tag == "Grind") {
                        path = hitForLanding.transform.gameObject.GetComponent<itween_demo>().pathName;
                        pathScript = hitForLanding.transform.gameObject.GetComponent<itween_demo>();

                    }
                }
                //Outside of above range is a failed click and landing
                if (hitForLanding.distance > failGrindClickMax && Input.GetButtonDown("LandGrind") && hit.collider.tag == "Grind" || hitForLanding.distance < failGrindClickMin && Input.GetButtonDown("LandGrind") && hit.collider.tag == "Grind") {
                    jump = 1;
                    clicked = true;

                    playerAnim.SetBool("failedLanding", true);
                }
            }
        }

    }

    void movePlayerOnPath(float v) {

        pathScript.moveAlongPath(v, gameObject);
        pathScript.endGrind(this);

    }

    void calculatingMultiplyer() {

        if (m_grounded && clicked) {
            //failed click
            if (jump == 1) {
                jump = 0;
                Multiplier = 1;
                // runSpeed = 15 + (slideMultiplyer * .25f);
                clicked = false;
            }
            // successfulClickMin clicked
            if (jump == 2) {
                jump = 0;
                Multiplier += slideMultiAdditon;
                // runSpeed = 15 + (slideMultiplyer * .25f);
                clicked = false;
            }
        }
        //Didnt click
        if (m_grounded && !clicked)
            if (jump == 1) {
                jump = 0;
                Multiplier = 1;
                // runSpeed = 15 + (slideMultiplyer * .25f);
                playerAnim.SetBool("failedLanding", true);
            }
    }
} 

