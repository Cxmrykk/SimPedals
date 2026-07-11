> [!WARNING]
> (AI Generated, proceed with caution)

---

# 📦 Material List (Bill of Materials)

### 1. 3D Printing Filament
*   **Rigid Parts (PLA+ / PETG / ABS / ASA):** 
    *   You will need approximately 2–3 kg of a high-strength filament. Standard PLA can be brittle under load; PLA+ or PETG is highly recommended for the pedal arms, bases, and plates.
*   **Flexible Parts (TPU / TPE):** 
    *   Required for the `TPE Brake Bushing.STL`. Use an 83A to 95A hardness flexible filament. (Adjusting infill density during slicing will change the stiffness of the brake pedal).

### 2. Electronics
*   **Microcontroller:** 1x Arduino Pro Micro or Arduino Leonardo (Must be 32u4-based for HID Gamepad support).
*   **Sensors:** 
    *   2x Linear Hall Effect Sensors (for Throttle and Clutch).
    *   1x NA151 Load Cell - 200kg (for Brake).
*   **Amplifier:** 1x HX711 Load Cell Amplifier Board.
*   **Magnets:** 2x Neodymium Magnets (6x2mm).
*   **Wiring:** Standard 22-24 AWG hookup wire and solder.

### 3. Hardware & Bearings
*   **Bearings:** 6x 625-size bearings (5x16x5mm).
*   **Rod Ends:** 3x M6 Female Rod Ends (Si6M6 / Clevis).
*   **Locking Collars:** 3x Retaining Lock Collars (6x12x8mm).
*   **Springs:** 3x Heavy-duty compression springs (Sourced from a hardware store; varying stiffness based on preference for throttle/clutch).
*   **Extrusion (Frame):** 
    *   2x 2020 Aluminum Extrusion (370mm length).
    *   2x 2020 Aluminum Extrusion (130mm length).
    *   4x 2020 Corner Brackets (with associated T-nuts and M5 bolts).

### 4. Fasteners (Nuts, Bolts, Washers)
*   **M4:** 6x M4x16mm Button Head Cap Screws (BHCS) - *For attaching pedal plates.*
*   **M5:**
    *   9x M5x50mm Socket Head Cap Screws (SHCS)
    *   15x M5x40mm SHCS
    *   (Optional) 6x M5x12mm SHCS - *For rear spring pivots to avoid hitting the spring.*
    *   21x M5 Standard Nuts
    *   6x M5 Nyloc Nuts
    *   12x M5 Washers
*   **M6:**
    *   3x M6x40mm SHCS
    *   3x M6x130mm SHCS (Minimum length, can be longer)
    *   6x M6 Nuts
    *   3x M6 Large Washers
*   **M3 (Not explicitly in BOM, but required for sensors):** Small M3 bolts/nuts for mounting the Hall Effect sensor brackets.

---

# 🛠️ Assembly Instructions

### Phase 1: 3D Printing the Parts
1.  **Print Structural Parts:** Print the modified SCAD files (Base Plates, Side Plates, Spring Back Plates, Load Cell Brackets) and the standard STLs (Pedal Bearing Mounts, Spacers, Spring Seats) in PLA+ or PETG.
    *   *Note:* Ensure you print mirrored base plates where necessary so the tabs face outward on both sides of each pedal.
2.  **Print the Brake Bushings:** Print the `TPE Brake Bushing` using TPU/TPE. 
    *   *Tip:* Set walls/perimeters to `0` and use infill only (e.g., 50% to 80% Gyroid or Grid). This allows the bushing to compress consistently. Adjust infill percentage to change brake stiffness.
3.  **Clean up:** Run a drill bit through the printed slide bushes to ensure the M6 bolts can slide through them smoothly.

### Phase 2: Pedal Arm Assembly
*Perform this for Throttle, Brake, and Clutch.*
1.  **Install Bearings:** Press two 625 bearings into the bottom pivot of the 3D-printed pedal arm. Ensure you place the **Pedal Bearing Crush Tube** between the two bearings before fully seating them.
2.  **Attach Lower Bolt:** Pass an M5x40mm bolt through the bottom joint and loosely attach a nut. 
3.  **Install Mid-Spacer:** Slot the printed mid-spacer into the pedal arm (align the anti-rotation dots) and secure it with another nut and bolt.
4.  **Attach Pedal Bracket:** Bolt the printed pedal mounting bracket to the top of the arm using two M5 bolts. *(Use the longer bracket variant for the Throttle).*
5.  **Insert Magnets:** For the Throttle and Clutch arms, apply a drop of superglue and press the 6x2mm magnets into the designated slot on the arm pivot.

### Phase 3: Base & Frame Assembly
1.  **Build the Pedals Bases:** 
    *   Take a left and right Base Plate. 
    *   Pass an M5x50mm bolt and washer through one plate, through the bottom bearing of the pedal arm, and out the other plate. Secure loosely with a washer and nut.
    *   Place a printed `Limit Stop Tube` spacer at the back slot of the base plates. Pass a bolt through to act as an adjustable backstop for the pedal.
2.  **Assemble the 2020 Frame:** Connect the 370mm and 130mm extrusions into a rectangle using the 2020 corner brackets.
3.  **Mount Bases to Frame:** Bolt the assembled pedal bases to the aluminum extrusion frame using T-nuts. Leave enough space between them for comfortable operation.

### Phase 4: Spring & Clevis Assembly
1.  **Prepare the Guide Bolt:** Take an M6x130mm bolt. Slide the 6x12x8mm locking collar all the way up to the bolt head and lock it in place.
2.  **Stack the Hardware:** 
    *   Slide the bolt through the printed Slide Bush (which sits inside the Spring Back Plate). Add a dab of grease to the bolt shaft.
    *   Slide on a printed Spring Seat, the compression spring (or TPE bushings for the brake), and another Spring Seat.
    *   Add a large M6 washer, followed by an M6 Nyloc nut. Tighten to set your baseline spring preload.
3.  **Attach Rod End:** Thread the M6 Rod End (Clevis) onto the end of the bolt.
4.  **Mount to Pedal:** Attach the Rod End to the rear of the pedal arm using an M6x40mm bolt and the two `Clevis Spacers`. (Use higher holes for linear throttle feel, lower holes for an "over-center" clutch feel).
5.  **Mount Spring Plate to Base:** Bolt the Spring Back Plate to the rear of the pedal base using short M5 bolts and Nyloc nuts. *Do not over-tighten; this pivot needs to rotate freely.*

### Phase 5: Brake Pedal Specifics
1.  **Mount Load Cell Plates:** Sandwich the two 3mm Load Cell Mounting Plates inside the rear base assembly.
2.  **Install Load Cell:** Mount the 200kg NA151 Load Cell between these plates using two M5x40mm bolts. 
3.  **Attach Bracket:** Attach the `Angled Load Cell Bracket` to the top of the load cell using an M5 bolt and a washer (to prevent the nut from pulling through the plastic).

### Phase 6: Pedal Plates
1.  **Attach Faces:** Attach the `Fully Printed` pedal faces, or your 3D-printed curved sheet metal equivalents, to the pedal mounts using M4x16mm BHCS bolts. 

### Phase 7: Electronics & Wiring
1.  **Hall Effect Sensors (Throttle & Clutch):**
    *   Solder VCC, GND, and Signal wires to the sensors.
    *   Screw the sensors into the `Hall Effect Mounts` and adjust the height until they just barely touch the magnet when the pedal is fully depressed.
    *   Wire to Arduino: VCC to 5V, GND to GND. Throttle Signal to **A2**, Clutch Signal to **A3**.
2.  **Load Cell Amplifier (HX711) Mod:**
    *   *Crucial Step for 80Hz Polling:* Desolder pin 15 of the HX711 chip and lift it so it no longer touches the pad. Bridge pin 15 to pin 16 (VCC) with solder.
3.  **Load Cell Wiring:**
    *   Load Cell to HX711: Red to `E+`, Black to `E-`, Green to `A-`, White to `A+`.
    *   HX711 to Arduino: VCC to 5V, GND to GND, `DT` (Data) to **Pin 2**, `SCK` (Clock) to **Pin 3**.

### Phase 8: Software & Calibration
1.  **Library Install:** Open the Arduino IDE. Go to Library Manager and install the **HX711** library and the **HID-Project** library.
2.  **Upload:** Open `Sim_Pedals.ino`, select your Arduino board (Leonardo / Micro), and upload the sketch.
3.  **Calibration:**
    *   Open the Arduino Serial Monitor (Set baud rate to `115200`).
    *   Type `Y` and press enter.
    *   You have 1 minute: smoothly press all three pedals to their maximum physical limits and release them completely multiple times.
    *   Once a minute passes with no inputs, the Arduino will save the calibration limits to the EEPROM. 

Your pedals are now ready to be mounted to your sim rig!