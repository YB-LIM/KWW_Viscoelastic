C**********************************************************************************************
C     UCREEPNETWORK subroutine for stretched exponential model (KWW model)
C   
C     AUTHOR: Youngbin LIM
C     CONTACT: Youngbin.LIM@3ds.com
C
C**********************************************************************************************
C     PROPS(1)       : Instantaneous elastic modulus in equilibrium network
C     PROPS(2)       : Stress ratio in viscoelastic network
C     PROPS(3)       : Material parameter Beta (Exponent)
C     PROPS(4)       : Material parameter tau  (Characteristic decay time)
C     PROPS(5)       : Modulus flag. 0 = Instantaneous, 1 = Long term     
C
C**********************************************************************************************
C
      subroutine ucreepnetwork (
C Must be updated
     *   outputData,
C Can be updated
     *   statev,
C Information (Read only)
     *   nOutput,
     *   nstatv,
     *   networkid,
     *   coords,
     *   temp,
     *   dtemp,
     *   nfield,
     *   predef,
     *   dpred,
     *   nprops,
     *   props,
     *   i_array,
     *   niarray,
     *   r_array,
     *   nrarray,
     *   c_array,
     *   ncarray)
C
      include 'aba_param.inc'
C
      parameter( io_creep_equiv_creepinc       = 1,
     *           io_creep_deqcreepinc_deqcreep = 2,
     *           io_creep_deqcreepinc_dqtild   = 3,
     *           io_creep_deqcreepinc_dinv1crp = 4,
     *           io_creep_deqcreepinc_dinv1    = 5,
     *           io_creep_deqcreepinc_dinv2    = 6,
     *           io_creep_deqcreepinc_ddetf    = 7,
     *           io_creep_deqcreepinc_dpress   = 8 )
C
      parameter( i_creep_kstep   = 1,
     *           i_creep_kinc    = 2,
     *           i_creep_noel    = 3,
     *           i_creep_npt     = 4,
     *           i_creep_layer   = 5,
     *           i_creep_kspt    = 6,
     *           i_creep_lend    = 7 )
C
      parameter( ir_creep_step_time  = 1,
     *           ir_creep_total_time = 2,
     *           ir_creep_creep_time = 3,
     *           ir_creep_timeinc    = 4,
     *           ir_creep_equiv_creep_strain = 5,
     *           ir_creep_qtild      = 6,
     *           ir_creep_inv1crp    = 7,
     *           ir_creep_inv1       = 8,
     *           ir_creep_inv2       = 9,
     *           ir_creep_detf       = 10,
     *           ir_creep_press      = 11 )
C
      parameter( ic_creep_material_name = 1 )
      parameter(ZERO=0.D0, ONE=1.D0, TOL=1.D-4)
C
      dimension 
     *   statev(nstatv),
     *   predef(nfield),
     *   dpred(nfield),
     *   coords(*),
     *   props(nprops),
     *   outputData(nOutput),
     *   i_array(niarray),
     *   r_array(nrarray)

      character*80 c_array(ncarray)
C
C     Read material parameter from PROPS
C
      E0   = PROPS(1)
      r    = PROPS(2)
      Beta = PROPS(3)
      tau  = PROPS(4)
      Flag = PROPS(5)
C     
C     Assign necessary variable
C
      sig_qtild = r_array(ir_creep_qtild)
      dt        = r_array(ir_creep_timeinc)
      detF      = r_array(ir_creep_detf)
      time      = r_array(ir_creep_step_time)   ! Step time
C
C     Calculate value that appear frequently 
C
      IF ( Flag.eq.0 ) THEN ! Instantaneous
        Alpha = (ONE/r) * Beta/(detF*E0*tau)
      ELSE IF (Flag.eq.1 ) THEN ! Long-Term
        Alpha = ((ONE - r)/r) * Beta/(detF*E0*tau)
      ELSE
        WRITE(6,*) " ***** ERROR : Modulus Flag should be 0 or 1 ***** "
        CALL XIT
      END IF
C
      t_pow = (time/tau + TOL)**(Beta - ONE) ! TOL is added to prevent division by zero
C     
C     Define euiquivalent creep strain increment
C
      decr       = Alpha*t_pow*sig_qtild*dt
      decrdq     = Alpha*t_pow*dt
      decrdJ     = -(Alpha/detF)*t_pow*sig_qtild*dt
C
C     Set output
C
      outputData(io_creep_equiv_creepinc)       = decr
      outputData(io_creep_deqcreepinc_deqcreep) = ZERO
      outputData(io_creep_deqcreepinc_dqtild)   = decrdq
      outputData(io_creep_deqcreepinc_dinv1crp) = ZERO
      outputData(io_creep_deqcreepinc_dinv1)    = ZERO
      outputData(io_creep_deqcreepinc_dinv2)    = ZERO
      outputData(io_creep_deqcreepinc_ddetf)    = decrdJ
      outputData(io_creep_deqcreepinc_dpress)   = ZERO
C
      return
      end