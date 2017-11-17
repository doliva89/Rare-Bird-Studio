using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class PlayerMovement : MonoBehaviour {

    itween_demo pathScript;
    public string path;
    public float walkSpeed;
    public float runSpeed;
    public float steerSpeed;
    public float maxStamina;
    public float initialJumpForce;
    public float continJumpForce;
    public float negativeJumpForce;
    public float Maxjumpcharge;

    public float slideStartAngel;
    public float Multiplier;
    public float speedBonusRun;
    public float speedBonuswalk;
    public float slideMultiAdditon;
    public float burmModifier;

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
    float orientation;
    Camera cam;
    ParticleSystem dust;
    Rigidbody rb;
    Vector3 moveDir;
    Vector3 slidingForce;
    Vector3 globalForce;

    Vector3 oldPos;
   
    private RaycastHit hit;
    Vector3 newHit;
    Quaternion currentRot;
    private float gravity;
    private float movementSpeed;
    private float worldForwardAngle;
    private float worldRightAngle;
    private float jumpCharger;
    float stamina;
    Animator playerAnim;
    private int jump = 0;

    
    private bool running;
    private bool clicked;
    private bool negativeGravity;
    public bool m_grounded;
    float time;
    float blendX;
    float blendY;


    void Awake() {
        dust = GetComponentInChildren<ParticleSystem>();
        globalForce = Vector3.zero;
        rb = GetComponent<Rigidbody>();
        playerAnim = GameObject.FindGameObjectWithTag("kid").GetComponent<Animator>();
       // gravity = .87f;
        cam = Camera.main;
        newHit = Vector3.zero;
       
        }

    void Update() {
        float v = Input.GetAxis("Vertical");
        Jump();
        Landing();
        if (Input.GetMouseButton(0) && m_grounded || Input.GetButton("Slide") && m_grounded && !grind) {
            sliding = true;
            running = false;
            
        }
        else if (Input.GetButtonUp("Slide")) {
            sliding = false;
        }
        if (grind) {
            pathScript.detectGrind(/*gameObject*/);
            movePlayerOnPath(.3f * Multiplier);
          
        }
      if(!sliding)
            dust.Play();
      
    }

    void FixedUpdate() {


        ///Jump();
        ///
      
         

      //  print(dust.isPlaying);
        float h = Input.GetAxis("Horizontal");
        float v = Input.GetAxis("Vertical");
       
        blendX = playerAnim.GetFloat("blendX");
        blendY = playerAnim.GetFloat("blendY");
        time += Time.deltaTime;
      //  if (time >= .5) {
           // speed = Vector3.Distance(oldPos, transform.position) * 10;
           // time = 0;
       // }

        m_grounded = IsGrounded();
        checkForSlopes();
        Movement(h, v);
        //  Landing();

        //checkForSlopes();
        calculatingAngles();
        calculatingMultiplyer();


        speed = Vector3.Distance(oldPos, transform.position) ;
        oldPos = transform.position;

        playerAnim.SetBool("jumpIsTrue", !m_grounded);
       
    }


    bool IsGrounded() {

        Ray ray = new Ray(transform.position, -transform.up);

        //Raycast to check if the player is grounded or not
        if (Physics.Raycast(ray, out hit, .8f)) {
            newHit = Vector3.Lerp(newHit, hit.normal, Time.deltaTime);
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
           
            stamina += Time.deltaTime;

            running = true;
            sliding = false;


        }
        else {
            running = false;
           // stamina = 0;
        }


        if (running) {
            if (stamina <= maxStamina)
                movementSpeed = runSpeed + (Multiplier * speedBonusRun);
            else {
                running = false;
                movementSpeed = walkSpeed + (Multiplier * speedBonuswalk);
                if (stamina >= 3)
                    stamina = 0;
            }

        }
        else if (v != 0 || x != 0 && !running) {
            movementSpeed = walkSpeed + (Multiplier * speedBonuswalk); ;

        }
        else 
            movementSpeed = 0;

        if (sliding) {

            float bias = 1, tSpeed =Mathf.Abs( blendY * speed);
            bias -= (tSpeed);
           
            playerAnim.SetBool("isSliding", true);
           
            Vector2 input = new Vector2(x, v);
            Vector3 mvd = transform.TransformDirection(new Vector3(0, 0, /*blendY * 10*/ input.magnitude));
            float dir = Vector3.Dot(globalForce.normalized, mvd.normalized);
           
            dir = Mathf.Clamp01(dir + 0.5f);
           
            Debug.DrawRay(transform.position, globalForce.normalized, Color.magenta);
            Debug.DrawRay(transform.position, mvd.normalized, Color.black);
           // playerAnim.SetFloat("blendX", Vector3.Dot(transform.forward, globalForce.normalized));
            playerAnim.SetFloat("blendY", v + Mathf.Abs(x));

            moveDir =  (mvd * steerSpeed )/* * dir*/;
            //float rotSpeed = 200, rotScalar = playerAnim.GetFloat("rotVal");
            //transform.Rotate(new Vector3(0, ((rotSpeed * bias)* Time.deltaTime) * (rotScalar/**speed*/), 0));
            
            rb.AddForce(/*transform.position + */( moveDir  * Time.deltaTime), ForceMode.VelocityChange);
            
           print(mvd);
        }

        if (!sliding) {

            playerAnim.SetBool("isSliding", false);
            //The Player is running
            if (v != 0 || x != 0)
                //rb.MovePosition(transform.position + (transform.forward* movementSpeed * Time.deltaTime));
                rb.MovePosition(transform.localPosition + (transform.forward * movementSpeed * Time.deltaTime));

            playerAnim.SetFloat("walkSpeed", Mathf.Abs(v + x));
            //dust.Stop();
        }

    }


    void Jump() {
        //Player jumps up
        if (Input.GetButtonDown("Jump") && m_grounded == true) {


            playerAnim.SetBool("failedLanding", false);

            gravity = 0.87f;
            rb.AddForce(transform.up * initialJumpForce + (transform.forward * movementSpeed) , ForceMode.VelocityChange);
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
           // sliding = false;
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
            Quaternion targetRotation = Quaternion.FromToRotation(transform.up,hit.normal) * transform.rotation;

            targetRotation = Quaternion.Euler(targetRotation.eulerAngles.x, currentRot.eulerAngles.y/*targetRotation.eulerAngles.y*/, targetRotation.eulerAngles.z);
            transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, (Time.deltaTime * 20) * (Mathf.Clamp(v + Mathf.Abs(h), -1f, 1)));
        }

        ////If the player isn't grounded rotate them so their transform up is the same as the worlds up
        else if (!m_grounded && !sliding )   {
            Quaternion targetRotation = Quaternion.FromToRotation(transform.up, Vector3.up) * transform.rotation;
            targetRotation = Quaternion.Euler(targetRotation.eulerAngles.x, /*cam.transform.eulerAngles.y*/currentRot.eulerAngles.y, targetRotation.eulerAngles.z);
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
                        path = hitForLanding.transform.gameObject.GetComponentInParent<itween_demo>().pathName;
                        pathScript = hitForLanding.transform.gameObject.GetComponentInParent<itween_demo>();

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

        pathScript.moveAlongPath(v/*, gameObject*/);
        pathScript.endGrind(this);
        if (!pathScript.onPath) {
           
            rb.AddForce(pathScript.gameObject.transform.forward * (speed * Multiplier), ForceMode.Impulse);
            path = null;
            pathScript = null;
        }
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

