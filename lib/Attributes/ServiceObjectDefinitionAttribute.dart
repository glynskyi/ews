class ServiceObjectDefinitionAttribute {
  final String XmlElementName;
  final bool ReturnedByServer;

  const ServiceObjectDefinitionAttribute(this.XmlElementName, [this.ReturnedByServer = true]);
}