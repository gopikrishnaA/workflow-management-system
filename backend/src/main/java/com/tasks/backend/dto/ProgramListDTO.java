package com.tasks.backend.dto;

import java.util.List;

import com.tasks.backend.entities.Program;

public class ProgramListDTO {
  private List<Program> programList;

  public List<Program> getProgramList() {
    return programList;
  }

  public void setProgramList(List<Program> programList) {
    this.programList = programList;
  }
}
