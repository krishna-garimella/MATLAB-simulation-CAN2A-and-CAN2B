function generateMsgsMod()
    %Create the CAN message with following arguments 
    %canMessage(<Message ID>,<Enable CAN 2.0B>,Data Length in bits)
    msgTx01 = canMessage(01, true, 4);
    msgTx500 = canMessage(500, true, 0);
    msgTx800 = canMessage(800, true, 6);
    msgTx1110 = canMessage(1110, true, 0);
    msgTx3000 = canMessage(3000, true, 8);
    
    % Create a CAN channel on which to transmit.
    txCh = canChannel('MathWorks', 'Virtual 1', 1);

    % Register each message on the channel at a specified periodic rate
    %Arguments
    %transmitPeriodic(<NameOfTransmissionChannel,MessageVariableName,'ON',<Periodicity
    %in seconds>)
    transmitPeriodic(txCh, msgTx01, 'On', 0.500)
    transmitPeriodic(txCh, msgTx500, 'On', 0.500)
    transmitPeriodic(txCh, msgTx800, 'On', 0.500);
    transmitPeriodic(txCh, msgTx1110, 'On', 1);
    transmitPeriodic(txCh, msgTx3000, 'On', 1);
    
    
    % Start the CAN transmission channel.
    start(txCh);
    
    % Run for several seconds incrementing the message data regularly.
    for ii = 1:40
        % Increment the message data bytes.
        msgTx01.Data = msgTx01.Data + 1
        msgTx500.Data = msgTx500.Data + 1
        msgTx800.Data = msgTx800.Data + 1
        msgTx1110.Data = msgTx1110.Data + 1
        msgTx3000.Data = msgTx3000.Data + 1
        
        % Wait for a time period.
        pause(0.1);
    end

    % Stop the CAN transmission channel.
    stop(txCh);
end