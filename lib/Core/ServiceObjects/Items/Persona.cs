/*
 * Exchange Web Services Managed API
 *
 * Copyright (c) Microsoft Corporation
 * All rights reserved.
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
 * to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */




    /// <summary>
    /// Represents a Persona. Properties available on Personas are defined in the PersonaSchema class.
    /// </summary>
    [Attachable]
    [ServiceObjectDefinition(XmlElementNames.Persona)]
 class Persona : Item
    {
        /// <summary>
        /// Initializes an unsaved local instance of <see cref="Persona"/>. To bind to an existing Persona, use Persona.Bind() instead.
        /// </summary>
        /// <param name="service">The ExchangeService object to which the Persona will be bound.</param>
 Persona(ExchangeService service)
            : super(service)
        {
            this.PersonaType = "";
            this.CreationTime = null;
            this.DisplayNameFirstLastHeader = "";
            this.DisplayNameLastFirstHeader = "";
            this.DisplayName = "";
            this.DisplayNameFirstLast = "";
            this.DisplayNameLastFirst = "";
            this.FileAs = "";
            this.Generation = "";
            this.DisplayNamePrefix = "";
            this.GivenName = "";
            this.Surname = "";
            this.Title = "";
            this.CompanyName = "";
            this.ImAddress = "";
            this.HomeCity = "";
            this.WorkCity = "";
            this.Alias = "";
            this.RelevanceScore = 0;

            // Remaining properties are initialized when the property definition is created in
            // PersonaSchema.cs.
        }

        /// <summary>
        /// Binds to an existing Persona and loads the specified set of properties.
        /// Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="service">The service to use to bind to the Persona.</param>
        /// <param name="id">The Id of the Persona to bind to.</param>
        /// <param name="propertySet">The set of properties to load.</param>
        /// <returns>A Persona instance representing the Persona corresponding to the specified Id.</returns>
 static new Persona Bind(
            ExchangeService service,
            ItemId id,
            PropertySet propertySet)
        {
            return service.BindToItemGeneric<Persona>(id, propertySet);
        }

        /// <summary>
        /// Binds to an existing Persona and loads its first class properties.
        /// Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="service">The service to use to bind to the Persona.</param>
        /// <param name="id">The Id of the Persona to bind to.</param>
        /// <returns>A Persona instance representing the Persona corresponding to the specified Id.</returns>
 static new Persona Bind(ExchangeService service, ItemId id)
        {
            return Persona.Bind(
                service,
                id,
                PropertySet.FirstClassProperties);
        }

        /// <summary>
        /// method to return the schema associated with this type of object.
        /// </summary>
        /// <returns>The schema associated with this type of object.</returns>
@override
        ServiceObjectSchema GetSchema()
        {
            return PersonaSchema.Instance;
        }

        /// <summary>
        /// Gets the minimum required server version.
        /// </summary>
        /// <returns>Earliest Exchange version in which this service object type is supported.</returns>
@override
        ExchangeVersion GetMinimumRequiredServerVersion()
        {
            return ExchangeVersion.Exchange2013_SP1;
        }

        /// <summary>
        /// The property definition for the Id of this object.
        /// </summary>
        /// <returns>A PropertyDefinition instance.</returns>
@override
        PropertyDefinition GetIdPropertyDefinition()
        {
            return PersonaSchema.PersonaId;
        }

        /// <summary>
        /// Validates this instance.
        /// </summary>
@override
        void Validate()
        {
            super.Validate();
        }

        #region Properties

        /// <summary>
        /// Gets the persona id
        /// </summary>
        ItemId get PersonaId => this.PropertyBag[this.GetIdPropertyDefinition()];
        set PersonaId(ItemId value) => this.PropertyBag[this.GetIdPropertyDefinition()] = value;

        /// <summary>
        /// Gets the persona type
        /// </summary>
        String get PersonaType => this.PropertyBag[PersonaSchema.PersonaType];
        set PersonaType(String value) => this.PropertyBag[PersonaSchema.PersonaType] = value;

        /// <summary>
        /// Gets the creation time of the underlying contact
        /// </summary>
        DateTime? get CreationTime => this.PropertyBag[PersonaSchema.CreationTime];
        set CreationTime(DateTime? value) => this.PropertyBag[PersonaSchema.CreationTime] = value;

        /// <summary>
        /// Gets the header of the FirstLast display name
        /// </summary>
        String get DisplayNameFirstLastHeader => this.PropertyBag[PersonaSchema.DisplayNameFirstLastHeader];
        set DisplayNameFirstLastHeader(String value) => this.PropertyBag[PersonaSchema.DisplayNameFirstLastHeader] = value;

        /// <summary>
        /// Gets the header of the LastFirst display name
        /// </summary>
        String get DisplayNameLastFirstHeader => this.PropertyBag[PersonaSchema.DisplayNameLastFirstHeader];
        set DisplayNameLastFirstHeader(String value) => this.PropertyBag[PersonaSchema.DisplayNameLastFirstHeader] = value;

        /// <summary>
        /// Gets the display name
        /// </summary>
        String get DisplayName => this.PropertyBag[PersonaSchema.DisplayName];
        set DisplayName(String value) => this.PropertyBag[PersonaSchema.DisplayName] = value;

        /// <summary>
        /// Gets the display name in first last order
        /// </summary>
        String get DisplayNameFirstLast => this.PropertyBag[PersonaSchema.DisplayNameFirstLast];
        set DisplayNameFirstLast(String value) => this.PropertyBag[PersonaSchema.DisplayNameFirstLast] = value;

        /// <summary>
        /// Gets the display name in last first order
        /// </summary>
        String get DisplayNameLastFirst => this.PropertyBag[PersonaSchema.DisplayNameLastFirst];
        set DisplayNameLastFirst(String value) => this.PropertyBag[PersonaSchema.DisplayNameLastFirst] = value;

        /// <summary>
        /// Gets the name under which this Persona is filed as. FileAs can be manually set or
        /// can be automatically calculated based on the value of the FileAsMapping property.
        /// </summary>
        String get FileAs => this.PropertyBag[PersonaSchema.FileAs];
        set FileAs(String value) => this.PropertyBag[PersonaSchema.FileAs] = value;

        /// <summary>
        /// Gets the generation of the Persona
        /// </summary>
        String get Generation => this.PropertyBag[PersonaSchema.Generation];
        set Generation(String value) => this.PropertyBag[PersonaSchema.Generation] = value;

        /// <summary>
        /// Gets the DisplayNamePrefix of the Persona
        /// </summary>
        String get DisplayNamePrefix => this.PropertyBag[PersonaSchema.DisplayNamePrefix];
        set DisplayNamePrefix(String value) => this.PropertyBag[PersonaSchema.DisplayNamePrefix] = value;

        /// <summary>
        /// Gets the given name of the Persona
        /// </summary>
        String get GivenName => this.PropertyBag[PersonaSchema.GivenName];
        set GivenName(String value) => this.PropertyBag[PersonaSchema.GivenName] = value;

        /// <summary>
        /// Gets the surname of the Persona
        /// </summary>
        String get Surname => this.PropertyBag[PersonaSchema.Surname];
        set Surname(String value) => this.PropertyBag[PersonaSchema.Surname] = value;

        /// <summary>
        /// Gets the Persona's title
        /// </summary>
        String get Title => this.PropertyBag[PersonaSchema.Title];
        set Title(String value) => this.PropertyBag[PersonaSchema.Title] = value;

        /// <summary>
        /// Gets the company name of the Persona
        /// </summary>
        String get CompanyName => this.PropertyBag[PersonaSchema.CompanyName];
        set CompanyName(String value) => this.PropertyBag[PersonaSchema.CompanyName] = value;

        /// <summary>
        /// Gets the email of the persona
        /// </summary>
        PersonaEmailAddress get EmailAddress => this.PropertyBag[PersonaSchema.EmailAddress];
        set EmailAddress(PersonaEmailAddress value) => this.PropertyBag[PersonaSchema.EmailAddress] = value;

        /// <summary>
        /// Gets the list of e-mail addresses of the contact
        /// </summary>
        PersonaEmailAddressCollection get EmailAddresses => this.PropertyBag[PersonaSchema.EmailAddresses];
        set EmailAddresses(PersonaEmailAddressCollection value) => this.PropertyBag[PersonaSchema.EmailAddresses] = value;

        /// <summary>
        /// Gets the IM address of the persona
        /// </summary>
        String get ImAddress => this.PropertyBag[PersonaSchema.ImAddress];
        set ImAddress(String value) => this.PropertyBag[PersonaSchema.ImAddress] = value;

        /// <summary>
        /// Gets the city of the Persona's home
        /// </summary>
        String get HomeCity => this.PropertyBag[PersonaSchema.HomeCity];
        set HomeCity(String value) => this.PropertyBag[PersonaSchema.HomeCity] = value;

        /// <summary>
        /// Gets the city of the Persona's work place
        /// </summary>
        String get WorkCity => this.PropertyBag[PersonaSchema.WorkCity];
        set WorkCity(String value) => this.PropertyBag[PersonaSchema.WorkCity] = value;

        /// <summary>
        /// Gets the alias of the Persona
        /// </summary>
        String get Alias => this.PropertyBag[PersonaSchema.Alias];
        set Alias(String value) => this.PropertyBag[PersonaSchema.Alias] = value;

        /// <summary>
        /// Gets the relevance score
        /// </summary>
        int get RelevanceScore => this.PropertyBag[PersonaSchema.RelevanceScore];
        set RelevanceScore(int value) => this.PropertyBag[PersonaSchema.RelevanceScore] = value;

        /// <summary>
        /// Gets the list of attributions
        /// </summary>
        AttributionCollection get Attributions => this.PropertyBag[PersonaSchema.Attributions];
        set Attributions(AttributionCollection value) => this.PropertyBag[PersonaSchema.Attributions] = value;

        /// <summary>
        /// Gets the list of office locations
        /// </summary>
        AttributedStringCollection get OfficeLocations => this.PropertyBag[PersonaSchema.OfficeLocations];
        set OfficeLocations(AttributedStringCollection value) => this.PropertyBag[PersonaSchema.OfficeLocations] = value;

        /// <summary>
        /// Gets the list of IM addresses of the persona
        /// </summary>
        AttributedStringCollection get ImAddresses => this.PropertyBag[PersonaSchema.ImAddresses];
        set ImAddresses(AttributedStringCollection value) => this.PropertyBag[PersonaSchema.ImAddresses] = value;

        /// <summary>
        /// Gets the list of departments of the persona
        /// </summary>
        AttributedStringCollection get Departments => this.PropertyBag[PersonaSchema.Departments];
        set Departments(AttributedStringCollection value) => this.PropertyBag[PersonaSchema.Departments] = value;

        /// <summary>
        /// Gets the list of photo URLs
        /// </summary>
        AttributedStringCollection get ThirdPartyPhotoUrls => this.PropertyBag[PersonaSchema.ThirdPartyPhotoUrls];
        set ThirdPartyPhotoUrls(AttributedStringCollection value) => this.PropertyBag[PersonaSchema.ThirdPartyPhotoUrls] = value;

        #endregion
    }
