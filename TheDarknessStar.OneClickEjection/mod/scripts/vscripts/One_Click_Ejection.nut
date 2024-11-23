global function One_Click_Ejection_initialization

void function One_Click_Ejection_initialization(){
    thread One_Click_Ejection_initialization2()
}

void function One_Click_Ejection_initialization2(){
    WaitFrame()
    RegisterButtonPressedCallback( KEY_F1, One_Click_Ejection_main)
}

void function One_Click_Ejection_main(int parameter)
{
	entity player = GetLocalViewPlayer()
	entity cockpit = player.GetCockpit()
    if ( !player.IsTitan() )
    return
    if ( !IsAlive( player ) )
    return
    if ( IsValid( player.GetParent() ) )
    return
    if ( TitanEjectIsDisabled() )
    {
        EmitSoundOnEntity( player, "CoOp_SentryGun_DeploymentDeniedBeep" )
        SetTimedEventNotification( 1.5, "" )
        SetTimedEventNotification( 1.5, "#NOTIFY_EJECT_DISABLED" )
        return
    }
    if ( Riff_TitanExitEnabled() == eTitanExitEnabled.Never || 	Riff_TitanExitEnabled() == eTitanExitEnabled.DisembarkOnly )
    return
    if ( player.ContextAction_IsMeleeExecution() )
    return
    PlayerEjects( player, cockpit )
    player.ClientCommand( "TitanEject " + 3 )
}