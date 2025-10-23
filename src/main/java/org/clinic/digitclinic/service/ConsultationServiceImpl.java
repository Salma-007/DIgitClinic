package org.clinic.digitclinic.service;

import org.clinic.digitclinic.dao.interfaces.ConsultationDAO;
import org.clinic.digitclinic.entity.Consultation;
import org.clinic.digitclinic.service.interfaces.ConsultationService;

import java.util.List;

public class ConsultationServiceImpl implements ConsultationService {

    private ConsultationDAO dao ;

    public ConsultationServiceImpl(ConsultationDAO dao){
        this.dao = dao;
    }

    @Override
    public void save(Consultation consultation) {
        dao.save(consultation);
    }

    @Override
    public void update(Consultation consultation) {
        dao.update(consultation);
    }

    @Override
    public void delete(Long id) {
        dao.delete(id);
    }

    @Override
    public Consultation findById(Long id) {
        return dao.findById(id);
    }

    @Override
    public List<Consultation> findAll() {
        return dao.findAll();
    }

    @Override
    public List<Consultation> findByPatientId(Long patientId) {
        try {
            return dao.findByPatientId(patientId);
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    @Override
    public List<Consultation> findByDoctor(Long doctorId) {
        try {
            return dao.findByDocteur(doctorId);
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    @Override
    public int countByPatientId(Long patientId) {
        return dao.countByPatientId(patientId);
    }
}
