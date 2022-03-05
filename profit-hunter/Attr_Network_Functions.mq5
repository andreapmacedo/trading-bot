// https://www.mql5.com/en/docs/network


// não dede estar no local certo
void ServerInfs()
{
	//--- Teste de Pingo do servidor.
	PrintFormat("LAST PING=%.f ms",
               TerminalInfoInteger(TERMINAL_PING_LAST)/1000.);
}
//_______________________________________/_________________________________________