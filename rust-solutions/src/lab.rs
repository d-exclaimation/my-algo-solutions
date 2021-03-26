//
//  lab.rust
//  dsa
//
//  Created by d-exclaimation on 2:36 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

pub fn result() {
    let mut lab_experiment = Box::new(Experiment2::new());
    let ((inertia_1, uncertain_1), (inertia_2, uncertain_2)) = lab_experiment.get_inertia();
    let (final_ng, uncertain_ng) = lab_experiment.conserved_moment_angular_speed();
    let (final_ng_2, uncertain_ng_2) = lab_experiment.conserved_energy_angular_speed();
    let (loss, uncertain_loss) = lab_experiment.energy_loss();

    println!("Inertia 1: {:.5} ({:.5})", inertia_1, uncertain_1);
    println!("Inertia 2: {:.5} ({:.5})", inertia_2, uncertain_2);
    println!("Final Angular Velocity: {:.5} ({:.5}) (Moment Conserved)", final_ng, uncertain_ng);
    println!("Final Angular Velocity: {:.5} ({:.5}) (Energy Conserved)", final_ng_2, uncertain_ng_2);
    println!("Energy loss: {:.5} ({:.5})", loss, uncertain_loss);
}

pub struct Experiment2 {
    pub data: DataSet,
    pub uncertain: DataSet,
    gravity: f64,
    init_ng: f64,
}

impl Experiment2 {
    pub fn new() -> Experiment2 {
        Experiment2 {
            data: DataSet::new_data(),
            uncertain: DataSet::new_uncertain(),
            gravity: 9.8,
            init_ng: 11.5
        }
    }

    fn calc_inertia_1(&mut self) {
        // I1 = (m1 * r1 * g) / (a1 - a2)
        self.data.inertia_1 = (self.data.mass_weight * self.data.radius_1 * self.gravity) / (self.data.acc_1 - self.data.acc_2);

        // 𝛅I1 = I1 * %𝛅(m1)
        self.uncertain.inertia_1 = self.data.inertia_1 * (self.uncertain.mass_weight / self.data.mass_weight);
    }

    fn calc_inertia_2(&mut self) {
        // I2 = 1/2 * M * R
        self.data.inertia_2 = (self.data.mass_system * self.data.radius_2.powi(2)) / 2.0;

        // 𝛅I2 = I2 * 2 * %𝛅(R)
        self.uncertain.inertia_2 = 2.0 * self.data.inertia_2 * (self.uncertain.radius_2 / self.data.radius_2);
    }

    fn get_angular_uncertain(&self, final_ng: f64) -> f64 {
        return final_ng *
            ((self.uncertain.inertia_1 / self.data.inertia_1) +
                ((self.uncertain.inertia_1 + self.uncertain.inertia_1) / (self.data.inertia_1 + self.data.inertia_2)));
    }

    pub fn get_inertia(&mut self) -> ((f64, f64), (f64, f64)) {
        self.calc_inertia_1();
        self.calc_inertia_2();
        return ((self.data.inertia_1, self.uncertain.inertia_1),
                (self.data.inertia_2, self.uncertain.inertia_2));
    }

    pub fn conserved_moment_angular_speed(&self) -> (f64, f64) {
        // wf = (I1 * wi) / (I1 + I2)
        let final_ng = (self.data.inertia_1 * self.init_ng) / (self.data.inertia_1 + self.data.inertia_2);

        // 𝛅wf = wf * %𝛅(I1) / %𝛅(I1 + I2)
        let uncertain_ng = self.get_angular_uncertain(final_ng);


        return (final_ng, uncertain_ng);
    }

    pub fn conserved_energy_angular_speed(&self) -> (f64, f64) {
        // wf = sqrt of ( (I1 * wi ^ 2) / (I1 + I2) )
        let final_ng = ((self.data.inertia_1 * self.init_ng.powi(2)) / (self.data.inertia_1 + self.data.inertia_2)).sqrt();

        // 𝛅(wf ^ 2) = wf ^ 2 * %𝛅(I1) / %𝛅(I1 + I2)
        let unsqrt_uncertain= self.get_angular_uncertain(final_ng.powi(2));

        // 𝛅(wf) =  sqrt(wf ^2 -  𝛅(wf ^ 2)) - wf
        let uncertain_ng = (final_ng.powi(2) + (unsqrt_uncertain)).sqrt() - final_ng;

        return (final_ng, uncertain_ng);
    }

    pub fn energy_loss(&self) -> (f64, f64) {
        let wf_true = 6.1;

        // E(loss) = EKi - EKf
        let eki = self.data.inertia_1 * self.init_ng.powi(2);
        let ekf = (self.data.inertia_1 + self.data.inertia_2) * wf_true;
        let ek_loss = 0.5 * eki - ekf;

        // 𝛅(E(loss)) = (Eki * %𝛅(I1) + Ekf * %𝛅(I1 + I2))
        let uncertain_loss = eki * (self.uncertain.inertia_1 / self.data.inertia_1) + ekf * (self.uncertain.inertia_2 / self.data.inertia_2);

        return (ek_loss, uncertain_loss);
    }
}


pub struct DataSet {
    pub mass_weight: f64,
    pub mass_system: f64,
    pub radius_1: f64,
    pub radius_2: f64,
    pub acc_1: f64,
    pub acc_2: f64,
    pub inertia_1: f64,
    pub inertia_2: f64,
}

impl DataSet {
    fn new_data() -> DataSet {
        DataSet {
            mass_weight: 0.18,
            mass_system: 6.891,
            radius_1: 0.015,
            radius_2: 0.145,
            acc_1: 0.3012,
            acc_2: -0.0198,
            inertia_1: 0.0,
            inertia_2: 0.0
        }
    }
    
    fn new_uncertain() -> DataSet {
        DataSet {
            mass_weight: 0.001,
            mass_system: 0.0,
            radius_1: 0.0,
            radius_2: 0.001,
            acc_1: 0.0,
            acc_2: 0.0,
            inertia_1: 0.0,
            inertia_2: 0.0
        }
    }
}