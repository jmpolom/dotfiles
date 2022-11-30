How to CAC on macOS
---

The best method for accessing DoD CAC enabled websites from macOS is to use a 
browser that supports the native smart/chip card support provided by macOS.
Browsers supporting the native smart card support include Safari (included with 
macOS) and any Chromium derivative browser such as Microsoft Edge, Google Chrome
or the open source Chromium variant. These browsers do not require any additional
software to access current generation DoD CACs and use certificates stored in the
macOS Keychain for SSL functions with CAC enabled websites. This means you get
middleware free access to your CAC and system-wide access to the DoD
certificates.

While OpenSC is a popular option to access CACs on Linux, this isn't required on
macOS unless you seek to access a CAC enabled website from Firefox. The major
downside to OpenSC on macOS is the only method for accessing the card is via
PKCS#11 which at times can be flaky. The author of this document recommends
setting this up only as a backup option for accessing CAC enabled websites on
macOS.

Where to obtain the DoD certificates
---

DoD intermediate CA certificates and CRL's can be downloaded from the [DoD PKI
Management webpage](https://crl.gds.disa.mil/).

The inability to download the root CA's from DISA via a website that doesn't
itself require CAC authentication is obnoxious. Frankly it's often convenient to
grab a zip archive of the certificates available from
[militarycac.com](https://militarycac.com/dodcerts.htm).

While `militarycac.com` isn't exactly a trusted resource it's often the easiest
option when simply trying to get access to `web.mail.mil`.

The result of any avenue for obtaining the DoD certificates should be a
directory full of certificate files ending in `.cer`.

Importing DoD Certificates into the macOS Keychain via Keychain Access
---

Likely the easiest method for many users is to download the DoD certificates
into a directory, and drag them into an open `Keychain Access.app` window. You
can bulk import all the certificates at once this way and it is very fast.  By
default the certificates will be imported to the user's keychain (`login`) which
is sufficient to allow a Chromium browser to pick them up. You can also change
the default selected keychain to the `System` keychain and import them there if
you need to access them from multiple user accounts.

Once the keys are imported into the Keychain, you must explicitly trust the DoD
root certificates. There are currently four (4) certificates you must take this action
on.

To trust the DoD root certificates, find the certificates named `DoD Root CA
<x>` where `<x>` is a single integer. Current DoD roots range from CA 2 to CA 5.
Double click on the entry for the root CA in the list and in the window that
opens with the details for the CA, expand the `Trust` section and select `Always
Trust` for the section `When using this certificate`.

You could issue trust more granularly and restrict trust only to certain uses
but that is beyond the scope of this documentation.

Importing DoD Certificates into the macOS Keychain via CLI
---

Now if you are like me and want a scriptable way to import certificates, it is
possible via the `security` command.

In a directory containing your `.cer` certificate files:

```
security add-trusted-cert -r trustRoot <root_cert_name>.cer
security add-certificates *.cer
```

Repeat the last command for each of the root certificate files that you need to
set trust for. The name of the root certificate files will be something like
`DoD Root CA <x>.cer` where `<x>` is a single digit integer. Currently `<x>`
ranges from 2 to 5.

Adding the certificates will not require authentication but adding trust to the
roots **will** require authentication (either password or Touch ID if
configured).
